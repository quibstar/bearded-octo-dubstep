class Topic < ActiveRecord::Base

  extend FriendlyId
    friendly_id :name, use: :slugged

  default_scope { order('id DESC') }

  has_many :groups, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

  belongs_to :client

  after_create :create_review_url


  def create_review_url
    review = Review.new
    review.topic_id = self.id
    review.save    
  end


  def self.get_user(id)
    @user = User.find(id)
  end

  def self.import(file)
    if(file)
      xls = nil
      case File.extname(file.original_filename)
        when ".xls" then xls = Roo::Spreadsheet.open(file.path, extension: :xls)
        when ".xlsx" then xls = Roo::Spreadsheet.open(file.path, extension: :xlsx)
        else raise "Unknown file type: #{file.original_filename}"
      end

      if xls
        xls.each(:ad => '^Ad$',:description_1 => '^Description line 1$',:description_2 => '^Description line 2$',:ad_group => '^Ad group$', :campaign => '^Campaign$', :display_url => '^Display URL$', :destination_url => '^Destination URL', :ad_id => "^Ad ID$", :ad_group_id => "^Ad group ID$", :ad_type => "^Ad type$") do |hash|
          #only import text ads
          if hash[:ad_type] == "Text ad"
            unless hash[:campaign] == " --" || hash[:campaign] == "Campaign" || hash[:campaign] == nil
              topic = Topic.find_by_name hash[:campaign]
              if !topic
                  topic = Topic.new
                  topic.name = hash[:campaign]
                  puts "New #{topic.name}"
                  
              end

              topic.save
                
              group = Group.find_by_ad_group_id hash[:ad_group_id]
              if !group
                group = Group.new
              end
              group.name = hash[:ad_group]
              group.ad_group_id = hash[:ad_group_id]
              group.destination_url = hash[:destination_url]
              group.display_url = hash[:display_url]
              group.network = "Google"
              topic.groups << group

              group.save

              content = hash[:ad] + "\n" + hash[:description_1] + "\n" + hash[:description_2]

              copy = Copy.find_by_ad_id hash[:ad_id]
              if !copy
                copy = Copy.new 
                copy.selected = true
              end

              copy.ad_id = hash[:ad_id]
              copy.content = content
              copy.editor = @user.email 
              group.copies << copy

            end
          end
        end
      end      
    end
  end

  def self.keywords(file)
    if(file)
      xls = nil
      case File.extname(file.original_filename)
        when ".xls" then xls = Roo::Spreadsheet.open(file.path, extension: :xls)
        when ".xlsx" then xls = Roo::Spreadsheet.open(file.path, extension: :xlsx)
        else raise "Unknown file type: #{file.original_filename}"
      end

      if xls
        xls.each(:campaign => 'Campaign', :keyword => '^Keyword$', :ad_group => 'Ad group', :keyword_id => '^Keyword ID$',:ad_group_id => '^Ad group ID$') do |hash|

          unless hash[:campaign] == " --" || hash[:campaign] == "Campaign" || hash[:campaign] == nil
            topic = Topic.find_by_name hash[:campaign]
            if !topic
                topic = Topic.new
                topic.name = hash[:campaign]
                puts "New #{topic.name}"
            end

            topic.save

            unless hash[:ad_group] == nil
                  
              group = Group.find_by_name hash[:ad_group]
              if !group
                group = Group.new
                group.save
              end

              group.name = hash[:ad_group]
              group.ad_group_id = hash[:ad_group_id]
              group.network = "Google"
              topic.groups << group

              if group.keywords !=nil

                keyword = Keyword.find_by_keyword_id(hash[:keyword_id])

                if keyword == nil
                  puts "KEYWORD IS NIL NOT FOUND"
                  keyword = Keyword.new 
                  keyword.group_id = group.id
                  keyword.word = hash[:keyword]
                  keyword.is_chosen = 1
                  keyword.under_review = 0
                  keyword.keyword_id = hash[:keyword_id]
                  keyword.ad_group_id = hash[:ad_group_id]
                  keyword.save
                else
                  puts "Keyword NOT NIL - FOUND"
                  keyword.group_id = group.id
                  keyword.word = hash[:keyword]
                  keyword.is_chosen = 1
                  keyword.under_review = 0
                  keyword.keyword_id = hash[:keyword_id]
                  keyword.ad_group_id = hash[:ad_group_id]
                  keyword.save
                end

                
                # group.keywords += "#{hash[:keyword]}\n"                
              # else
              #   group.keywords = "#{hash[:keyword]}\n"
              end
              group.save
            end
          end
        end
      end
    end
  end

  # def to_csv(topic)
  #   CSV.generate do |csv|
  #     csv << ['Ad state','Ad', 'Description line 1', 'Description line 2', 'Display URL', 'Destination URL', 'Campaign', 'Ad group', 'Status']
  #     topic.groups.where(:selected => true).each do |group|
  #      group.copies.each do |copy|
  #       con = copy.content.lines.map(&:chomp)
  #       csv << ['enabled', con[0], con[1], con[2], group.display_url, group.destination_url, topic.name, group.name, 'approved']
  #      end
  #     end
  #   end
  # end

end
