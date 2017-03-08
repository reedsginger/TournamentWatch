Dir.chdir("../../resources/hero_images")
Dir.entries(".").each do |name|
  if name.include?("hphover")
    new_name = name.chomp('_hphover.png')
    new_file = "medium_heroes/#{new_name}.png"
    File.rename(name, new_file)
  elsif name.include?("sb")
    new_name = name.chomp('_sb.png')
    new_file = "small_heroes/#{new_name}.png"
    File.rename(name, new_file)
  end
end
