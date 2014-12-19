class Slider < ActiveRecord::Base

	has_many :slides, :dependent => :destroy
	has_many :sections

validates :effectType,  :presence => true
validates :title,  :presence => true
validates :imageWidth,  :presence => true
validates :imageHeight,  :presence => true 

# attr_accessible  :title, :imageWidth, :imageHeight, :animSpeed, :startSlide, :directionNav, :controlLinks, :controlLinkThumbs, 
# :autoPlay, :pauseTime, :pauseOnHover, :captions, :captionPosition, :captionAnimation, :captionAnimationSpeed, :effectType, 
# :effect_3d, :innerSideColor, :transparentImg, :makeShadow, :shadowColor, :slices, :rows, :columns, :delay, :delayDir, 
# :depthOffset, :sliceGap, :easing, :fallBack, :fallBackSpeed, :effect_2d
end
