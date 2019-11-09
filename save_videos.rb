require 'open-uri'

FOLDER_NAME_IMAGES = 'steel_images'
FOLDER_NAME_VIDEOS = 'steel_videos'
FILE_PREFIX = 'steel'

def get_pics_from_line(line, count)
  img_start = line.index('<img src="https://cdn.onlyfans.com') + 10
  img_end = line.index('.jpg') + 4
  img_link = line[img_start, img_end - img_start]
  open("#{FOLDER_NAME_IMAGES}/#{FILE_PREFIX}#{count}.png", 'wb') do |file|
    file << open(img_link).read
  end
  img_link
end

def get_vids_from_line(line, count)
  vid_start = line.index('src=') + 5
  vid_end = line.index('.mp4') + 4
  vid_link = line[vid_start, vid_end - vid_start]
  open("#{FOLDER_NAME_VIDEOS}/#{FILE_PREFIX}#{count}.mp4", 'wb') do |file|
    file << open(vid_link).read
  end
  p vid_link
  vid_link
end


count = 1
text = File.open('source.txt', 'r').each_with_index do |line, index|
  if line.include?('<img src="https://cdn.onlyfans.com') && line.include?('.jpg') && !line.include?('/avatar.jpg')
    img_link = get_pics_from_line(line, count)
    p count
    count += 1
    p img_link if img_link
  end
  if line.include?('<video preload="none" playsinline="playsinline" controlslist="nodownload" poster="https://cdn.onlyfans.com') && line.include?('.mp4')
    vid_link = get_vids_from_line(line, count)
    count += 1
  end
end
