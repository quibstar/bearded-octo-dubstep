module CollectionsHelper

  def checked(asset)
    if asset == '1'
      'checked'
    else
      ''
    end
  end

  def catetory_ids(asset)
    if @collection.settings['categories'] == '1'
      cats = Array.new
      asset_ids = Array.new

      @collection.categories.each do |col_cat|
        cats << col_cat.id
      end

      Category.where(:id => cats).each do |cat|

        if asset == 'image'
          cat.images.each do |asset|
            asset_ids << asset.id
          end
        end

        if asset == 'document'
          cat.documents.each do |asset|
            asset_ids << asset.id
          end
        end

        if asset == 'user'
          cat.users.each do |asset|
            asset_ids << asset.id
          end
        end

        if asset == 'audio'
          cat.audios.each do |asset|
            asset_ids << asset.id
          end
        end

        if asset == 'youtube'
          cat.youtubes.each do |asset|
            asset_ids << asset.id
          end
        end

      end
      return asset_ids

    else
      asset_ids = @collection.settings['asset_ids'].split(",").map { |s| s.to_i }
    end

  end

end