class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
    	t.string	:title
		t.string :effectType
		t.string :effect
		t.string  :effect_3d
		t.string :effect_2d
		t.integer :imageWidth
		t.integer :imageHeight
		t.string :innerSideColor
		t.boolean :transparentImg
		t.boolean :makeShadow
		t.string :shadowColor
		t.integer :slices
		t.integer :rows
		t.integer :columns
		t.integer :delay
		t.string :delayDir
		t.integer :depthOffset
		t.integer :sliceGap
		t.string :easing
		t.string :fallBack
		t.integer :fallBackSpeed
		t.integer :animSpeed
		t.integer :startSlide
		t.boolean :directionNav
		t.boolean :controlLinks
		t.boolean :controlLinkThumbs
		t.string :controlThumbLocation
		t.boolean :autoPlay
		t.integer :pauseTime
		t.boolean :pauseOnHover
		t.boolean :captions
		t.string :captionPosition
		t.string :captionAnimation
		t.integer :captionAnimationSpeed
      t.timestamps
    end
  end
end
