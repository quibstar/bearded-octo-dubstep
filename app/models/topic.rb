class Topic < ActiveRecord::Base


  extend FriendlyId
    friendly_id :name, use: :slugged

  default_scope { order('id DESC') }

  has_many :groups, :dependent => :destroy


  def self.get_user(id)
    @user = User.find(id)
  end

  def self.import(file)
    xls = Roo::Spreadsheet.open(file.path, extension: :xlsx)
    xls.each(:ad => '^Ad$',:description_1 => 'Description line 1',:description_2 => 'Description line 2',:ad_group => 'Ad group', :campaign => 'Campaign', :display_url => 'Display URL', :destination_url => 'Destination URL') do |hash|

      
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
          end
          group.name = hash[:ad_group]
          group.destination_url = hash[:destination_url]
          group.display_url = hash[:display_url]
          group.network = "Google"
          topic.groups << group

          content = hash[:ad] + "\n" + hash[:description_1] + "\n" + hash[:description_2]
          copy = Copy.find_by_content content
          if !copy
            copy = Copy.new 
          end

          copy.content = content
          puts "TEST TEST TEST"
          copy.editor = @user.email
          group.copies << copy
        end
      end

    end

  end

  def to_csv(topic)
    CSV.generate do |csv|
      csv << ['Ad state','Ad', 'Description line 1', 'Description line 2', 'Display URL', 'Destination URL', 'Campaign', 'Ad group', 'Status']
      topic.groups.each do |group|
       group.copies.each do |copy|
        con = copy.content.lines.map(&:chomp)
        csv << ['enabled', con[0], con[1], con[2], group.display_url, group.destination_url, topic.name, group.name, 'approved']
       end
      end
    end
  end

end
