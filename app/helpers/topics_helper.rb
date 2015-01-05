module TopicsHelper

  def to_alphabet(i)
    alpha = ("A".."Z").to_a
    return alpha[i]
  end

  def selected_version(selected, i)
    if selected
      content_tag(:span, "Version #{to_alphabet(i)}", :class =>"selected-version")
    else
      content_tag(:span, "Version #{to_alphabet(i)}", :class =>"non-selected-version")
    end
  end

end
