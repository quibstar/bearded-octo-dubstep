module VersionsHelper

  def get_template(t)
    template = Template.where(:id => t)
  end

  def compare_properties(p1,p2)
    if p1 != p2
      label = "<span class='badge badge-negative'>Updated</span>"
      label.html_safe
    end
  end

end