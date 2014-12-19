class Section < ActiveRecord::Base
	# serialize :settings, ActiveRecord::Coders::Hstore
  has_paper_trail :on => [:update, :destroy]

	after_save :update_page_id
	
	def update_page_id
	 sections = Section.where(:parent_id => self.id)
	 sections.each do |s|
	 	s.update_attribute(:page_id ,self.page_id)
	 end
	#need updates for accordion and tab sub sections and content
	end 
	
	acts_as_list
	
	belongs_to :page

  #section will be associated to a footer
	belongs_to :footer

  #section will belong to a 'multi navigation' for functions
  belongs_to :mulit_navigation

  #section will belong to a 'shared content' for functions
  #belongs_to :shared_content 

  has_one :asset_by_category, :dependent => :destroy
  accepts_nested_attributes_for :asset_by_category

  has_one :social_network, :dependent => :destroy
  accepts_nested_attributes_for :social_network

  has_one :navigation_group, :dependent => :destroy
  accepts_nested_attributes_for :navigation_group

  has_one :navigation_branch, :dependent => :destroy
  accepts_nested_attributes_for :navigation_branch
  # I wonder abut doing has_one for sliders
	
  #many 'shared content' can be in a section
	has_and_belongs_to_many :shared_contents
  has_and_belongs_to_many :sliders
  has_and_belongs_to_many :testimonials
  has_and_belongs_to_many :publications
  has_and_belongs_to_many :forms
	has_and_belongs_to_many :youtubes
	has_and_belongs_to_many :faqs
  has_and_belongs_to_many :collections
	
	
	has_one :content, :dependent => :destroy
	accepts_nested_attributes_for :content #, :reject_if => proc { |attributes|attributes['content'].blank? } , :allow_destroy => true
		
	# Categories join models and association for categories
	has_many :asset_categories, :as => :categorizable, :dependent => :destroy
	has_many :categories, :through => :asset_categories
	 
  has_many :sub_sections, class_name: "Section",
                          foreign_key: "parent_id"
	
	
	attr_accessor :tabs
	after_create :create_tabs,:if => Proc.new{ self.section_type == "tabbed" }
  after_update :update_tabs,:if => Proc.new{ self.section_type == "tabbed" }

	attr_accessor :accordions
	after_create :create_accordions,:if => Proc.new{ self.section_type == "accordions" }
  after_update :update_accordions,:if => Proc.new{ self.section_type == "accordions" }
	
	attr_accessor :cols
	attr_accessor :column
	after_create :create_columns,:if => Proc.new{ self.section_type == "columns" }
	after_update :update_columns,:if => Proc.new{ self.section_type == "columns" }

 
  def create_tabs
    parent = Section.last
    tabs = @tabs.to_i 
  	tabs.times do |t|
  		tab_section(parent, t)
  	end
   end

   def update_tabs
     tab_count = Section.where(:parent_id => self.id)
     unless @accordions.to_i == 0
       if tab_count.count < @tabs.to_i
          tabs_to_create = @tabs.to_i - tab_count.count
          tabs_to_create.times do |t|
            tab_section(self, t)
          end
        else
          tabs_to_remove = tab_count.count - @tabs.to_i
          tabs_to_remove.times do |t|
            section = Section.where(:parent_id => self.id)
            section.last.destroy
          end
        end
      end
   end
     
  def tab_section(parent, t)
  	# Create tabs
		section = Section.new
		section.update_attributes(:tab => "tab #{t}", :section_type => 'tab',:parent_id => parent.id, :location => parent.location, :page_id => parent.page_id,:footer_id => parent.footer_id,
      :publication_id => parent.publication_id, :multi_navigation_id => parent.multi_navigation_id,:shared_content_id => parent.shared_content_id)
  end
  
	def create_accordions
		parent = Section.last
		accordions = @accordions.to_i 
			accordions.times do |t|
			accordion_section(parent, t)
		end
	end

  def update_accordions
    accordion_count = Section.where(:parent_id => self.id)
    unless @accordions.to_i == 0
      if accordion_count.count < @accordions.to_i
        accordions_to_create = @accordions.to_i - accordion_count.count
        accordions_to_create.times do |t|
          accordion_section(self, t)
        end
      else
        accordions_to_remove = accordion_count.count - @accordions.to_i
        accordions_to_remove.times do |t|
          section = Section.where(:parent_id => self.id)
          section.last.destroy
        end
      end
    end
  end

	def accordion_section(parent, t)
	# Create tabs
		section = Section.new
		section.update_attributes(:tab => "accordion #{t}", :section_type => 'accordion',:parent_id => parent.id, :location => parent.location, :page_id => parent.page_id,:footer_id => parent.footer_id,
      :publication_id => parent.publication_id,:multi_navigation_id => parent.multi_navigation_id, :shared_content_id => parent.shared_content_id)
	end
	
	
	
	def create_columns
    	parent = Section.last
    	if @column == "2h"
      		['col-50 first', 'col-50 last'].each do |col| 
       	 create_section(col, parent)
      end
    end 
    if @column == "4q"
      ['col-25 first','col-25','col-25', 'col-25 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    if @column == "1q-2q-1q"
      ['col-25 first','col-50', 'col-25 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    if @column == "2q-1q-1q"
      ['col-50 first','col-25', 'col-25 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
     if @column == "1q-1q-2q"
      ['col-25 first','col-25', 'col-50 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    
    if @column == "1q-3q"
      ['col-25 first', 'col-75 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    if @column == "3q-1q"
      ['col-75 first','col-25 last'].each do |col| 
        create_section(col, parent)
      end
    end 
      
    if @column == "3t"
      ['col-33 first','col-33','col-33 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    if @column == "1t-2t"
      ['col-33 first','col-66 last'].each do |col| 
        create_section(col, parent)
      end
    end
    if @column == "2t-1t"
      ['col-66 first','col-33 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    if @column == "5p"
      ['col-20 first','col-20','col-20','col-20','col-20 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    if @column == "two-eight"
      ['col-20 first','col-80 last'].each do |col| 
        create_section(col, parent)
      end
    end
        if @column == "eight-two"
      ['col-80 first','col-20 last'].each do |col| 
        create_section(col, parent)
      end
    end
        if @column == "six-four"
      ['col-60 first','col-40 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
      if @column == "four-six"
      ['col-40 first','col-60 last'].each do |col| 
        create_section(col, parent)
      end
    end
    
    if @column == "two-six-two"
      ['col-20','col-60','col-20 last'].each do |col| 
        create_section(col, parent)
      end
    end

  end
  
  def create_section(col, parent)
      Rails.logger.info "Create col: #{col} and parent: #{parent.id}"
      section = Section.new
      section.update_attributes(:column_class => col,:section_type => 'column',:parent_id => parent.id, 
        :location => parent.location, :page_id => parent.page_id,:footer_id => parent.footer_id, 
        :publication_id => parent.publication_id, :multi_navigation_id => parent.multi_navigation_id, 
        :shared_content_id => parent.shared_content_id)
  end
  
  
  def update_columns
    sections = Section.where(:parent_id => self.id)
    
    # two column
    # 50%
    if @column == "2h"
      update_section_two(2,'col-50 first', 'col-50 last', sections)
    end
    
    # 25% 75%
    if @column == "1q-3q"
      update_section_two(2,'col-25 first', 'col-75 last', sections)
    end
    
    # 75% 25%
    if @column == "3q-1q"
      update_section_two(2,'col-75 first', 'col-25 last', sections)
    end
    
    # 33% 66%
    if @column == "1t-2t"
      update_section_two(2,'col-33 first', 'col-66 last', sections)
    end
    
    # 66% 33%
    if @column == "2t-1t"
      update_section_two(2,'col-66 first', 'col-33 last', sections)
    end
    
    # 80% 20%
    if @column == "eight-two"
      update_section_two(2,'col-80 first', 'col-20 last', sections)
    end
    
    # 20% 80%
    if @column == "two-eight"
      update_section_two(2,'col-20 first', 'col-80 last', sections)
    end
    
    if @column == 'four-six'
      update_section_two(2,'col-40 first', 'col-60 last', sections)
    end
    
    if @column == 'six-four'
      update_section_two(2,'col-60 first', 'col-40 last', sections)
    end
    
    
    
    # equal columns
    # three equal columns
    if @column == '3t'
      update_section_equal(3,'col-33 first', 'col-33 last',sections)
    end
    #four equal columns
    if @column == '4q'
      update_section_equal(4,'col-25 first', 'col-25 last',sections)
    end
    #five equal columns
    if @column == '5p'
      update_section_equal(5,'col-20 first', 'col-20 last',sections)
    end

    #three col large center col
    # 20% 60% 20%
    if @column == 'two-six-two'
      update_section_three(3,'col-20 first','col-60', 'col-20 last',sections)
    end
    
    # 25% 50% 25%
    if @column == '1q-2q-1q'
      update_section_three(3,'col-25 first','col-50', 'col-25 last',sections)
    end
    # 50% 25% 25%
    if @column == '2q-1q-1q'
      update_section_three(3,'col-50 first','col-25', 'col-25 last',sections)
    end

    # 25% 25% 50%
    if @column == '1q-1q-2q'
      update_section_three(3,'col-25 first','col-25', 'col-50 last',sections)
    end
        
  end #end of def
    
    def update_section_equal(col_num,first_col, last_col, sections)
      Rails.logger.info "Update col_num: #{col_num} first_col: #{first_col} last_col: #{last_col} sections: #{sections}"
      if sections.count > col_num
        sections.each_with_index do |col, i|
          if i == 0
            col.update_attributes(:column_class => first_col)
          elsif i < (col_num -1)
            col.update_attributes(:column_class => first_col[0, 6])
          elsif i ==  (col_num -1)
            col.update_attributes(:column_class => last_col)
          else
            col.destroy
          end
        end
      elsif sections.count == col_num
          return
      else
        sections.each do |col, i|
          if i == 0
            col.update_attributes(:column_class => first_col)
          else
            col.update_attributes(:column_class => first_col[0, 6])
          end
        end
        remainder = col_num - sections.count 
        remainder.times do |r|
          create_section(first_col, self)
        end
        last = Section.where(:parent_id => self).last
        last.update_attributes(:column_class => last_col)
      end
    end
    
    def update_section_two(col_num,first_col, last_col, sections)
      if sections.count > col_num
        sections.each_with_index do |col, i|
          if i < (col_num -1)
            col.update_attributes(:column_class => first_col)
          elsif i == (col_num -1)
            col.update_attributes(:column_class => last_col)
          else
            col.destroy
          end
        end
      elsif sections.count == col_num
        sections.each_with_index do |col, i|
          if i == 0
            col.update_attributes(:column_class => first_col)
          elsif i < (col_num -1)
            col.update_attributes(:column_class => first_col[0, 6])
          elsif i ==  (col_num -1)
            col.update_attributes(:column_class => last_col)
          end
        end
      else
        sections.each do |col, i|
          if i == 0
            col.update_attributes(:column_class => first_col)
          else
            col.update_attributes(:column_class => first_col[0, 6])
          end
        end
        remainder = col_num - sections.count 
        remainder.times do |r|
          create_section(first_col, self)
        end
        last = Section.where(:parent_id => self).last
        last.update_attributes(:column_class => last_col)
      end
    end
    
    
    def update_section_three(col_num,first_col,mid_col, last_col, sections)
      if sections.count > col_num
        sections.each_with_index do |col, i|
          if i < (col_num -2)
            col.update_attributes(:column_class => first_col)
          elsif i ==  (col_num -1)
            col.update_attributes(:column_class => mid_col)
          elsif i ==  (col_num)
            col.update_attributes(:column_class => last_col)
          else
            col.destroy
          end
        end
      elsif sections.count == col_num
        sections.each_with_index do |col, i|
          if i == 0
            col.update_attributes(:column_class => first_col)
          elsif i < (col_num -1)
            col.update_attributes(:column_class => mid_col[0, 6])
          elsif i ==  (col_num -1)
            col.update_attributes(:column_class => last_col)
          end
        end
      else
        sections.each do |col|
          col.update_attributes(:column_class => first_col)
        end
        # create section if lest than col_count
        remainder = col_num - sections.count
        remainder.times do |r|
          create_section(first_col, self)
        end
        second = Section.where(:parent_id => self).second
        second.update_attributes(:column_class => mid_col)
        
        last = Section.where(:parent_id => self.id).last
        last.update_attributes(:column_class => last_col)
      end
    end

           
end
