Magickly.dragonfly.configure do |c|
  c.job :resize_with_blur do |size|
    process :convert, "-filter Gaussian -resize #{size}"
  end
  
  c.job :tilt_shift do |coefficients|
    if coefficients == 'true'
      # use default polynomial coefficients
      coefficients = '4,-4,1'
    end
    
    # note: can be made faster by decreasing blur radius passed to option:compose:args
    action = "\\( +clone -sparse-color Barycentric '0,0 black 0,%h white' -function polynomial #{coefficients} \\) -compose Blur -set option:compose:args 8 -composite"
    process :convert, action
  end
end