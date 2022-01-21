require 'open-uri'
    
namespace :smp do
  desc "Get the blogs and save them in DB "
  task load_data: :environment do    
    site = Site.find_or_create_by(name: "Single Man's Paradise", url: 'https://singlemansparadise.com')

    html_page  = "#{Rails.root}/lib/tasks/data/Blog Post Archives _ Single Man's Paradise.html"   
    doc = File.open(html_page) { |f| Nokogiri::XML(f) }
    
    doc.css('article').each do |blog|

      categories = blog.attr('class').scan(/category\-(\w+)/i).flatten
      author = blog.at('span' '.author').text
      native_page_url = blog.at('.entry-title a').attr('href')
      blog_page = Nokogiri::HTML(open(native_page_url))
  
      page = site.pages.create(
        title: blog.at('.entry-title').text,
        native_image_url: blog.at('img').attr('src'),
        native_page_url: native_page_url,
        date_published: blog.at('.published').text.to_date,
        author: Author.find_or_create_by(name: author),
        #body: blog_page.css('.entry-content p').text
        body: blog_page.css('.entry-content p').to_html
      )
      page.categories << categories.map{|n| Category.find_or_create_by(name: n)}
      puts page
    end  
  end


  #https://www.returnofkings.com/archives
  #cb-entry-content clearfix
    
  ###############################################
  desc "Get return of kings blogs and save them in DB "
  task load_return_of_kings: :environment do   
    site = Site.find_or_create_by(name: "Return of Kings", url: 'https://www.returnofkings.com/archives')
    #author = Author.find_or_create_by(name: 'Stickman')

    doc = Nokogiri::HTML(URI.open("https://www.returnofkings.com/archives"))

    doc.css('.cb-entry-content li a').each_with_index do |blog,i|
      list_url =  blog.attr('href')
      puts "getting #{list_url}"
      index_list = Nokogiri::HTML(URI.open(list_url)) 
      parse_index_list(index_list)  
      
    end
  end
end

def parse_index_list(index_list)     
  index_list.css('article').each_with_index do |l,i2|   
    puts "#{i2}) -------------------------------------------------"
    title = l.css('.cb-post-title').text
    publish_date = l.css('time')&.text
    publish_date = Date.parse(publish_date) if publish_date.present?
    author = l.css('.cb-author').text
    url_page = l.css('.cb-post-title a').attr('href').value
    categories = l.css('.cb-cateogry li')&.map(&:text)
    puts categories
    puts publish_date
    puts author
    puts title
    puts url_page
    page = Nokogiri::HTML(URI.open(url_page)).css('.cb-itemprop')
    page_html = page.css('p').to_html
    puts page_html
    
    binding.pry
  end

  if (next_page = index_list.css('.page-numbers')&.last&.attr('href'))
    parse_index_list(Nokogiri::HTML(URI.open(next_page)))
  end
end

=begin
      page = site.pages.new( 
        title: blog.css('.teaser__title').text,        
        date_published: blog.css('.teaser__date').text.to_date,
        native_page_url: url,
        author: author
      )
      puts "getting ##{i+1} #{page.title}"
        
      blog_doc = Nokogiri::HTML(open(url))
      page.content = blog_doc.css('.wp-content p').to_html
      page.save! 
      puts page

    end
=end 


 
=begin  
#####################################
  desc "Get the blogs and save them in DB "
  task load_stickman_data: :environment do   
    site = Site.find_or_create_by(name: "Stickman Bangkok", url: 'https://stickmanbangkok.com')
    author = Author.find_or_create_by(name: 'Stickman')
    (2001..20019).to_a.each do |year|
      puts "---- getting #{year} posts ---- "
      doc = Nokogiri::HTML(open("https://www.stickmanbangkok.com/weekly-column/#{year}"))
      
      doc.css('.teaser').each_with_index do |blog,i|
        
       
        url =  blog.css('a').attr('href').value
        page = site.pages.new( 
          title: blog.css('.teaser__title').text,        
          date_published: blog.css('.teaser__date').text.to_date,
          native_page_url: url,
          author: author
        )
        puts "getting ##{i+1} #{page.title}"
          
        blog_doc = Nokogiri::HTML(open(url))
        page.content = blog_doc.css('.wp-content p').to_html
        page.save! 
        puts page
      end  
    end    
  end
  
  
  ##################################
  desc "Get the blogs and save them in DB "
  task load_nomadphilippines_data: :environment do   
    site = Site.find_or_create_by(name: "Nomad Philippines", url: 'https://nomadphilippines.com')
    author = Author.find_or_create_by(name: 'Stickman')
    (1..1000).to_a.each do |page|
      puts "---- getting #{page} posts ---- "
      doc = Nokogiri::HTML(open("https://nomadphilippines.com/page/#{page}/"))
      
      doc.css('article').each_with_index do |blog,i|
        page = site.pages.new( 
          native_image_url: blog.css('.post-thumbnail img').attr('src'),          
          date_published:  blog.css('.post-date').text.to_date,
          title: blog.css('.post-title').text.squish,
          native_page_url: blog.css('.post-title a').attr('href').value,     
          #summary: blog.css('.entry').text.squish
        ) 
        
        c = blog.css('.post-category').text
        if c == "Special Offers"
          puts "skipping #{c}"
          next
        end
        
        puts "-=-=-=-=-=-=-=-= > getting #{page.title}"
        blog_doc = Nokogiri::HTML(open(page.native_page_url))      
        author = blog_doc.css('.author').text.squish      
        page.author = Author.find_or_create_by(name: author) 
        page.content = blog_doc.css('.entry-inner').to_html
        page.save!
        
        page.categories << Category.find_or_create_by(name: c) if c.present?
      
        binding.pry
               
    
      end  
    end    
  end
  



  
  desc "Get the blogs and save them in DB "
  task load_nomadphilippines_data: :environment do   
    site = Site.find_or_create_by(name: "Nomad Philippines", url: 'https://nomadphilippines.com')
    author = Author.find_or_create_by(name: 'Stickman')
    (1..1000).to_a.each do |page|
      puts "---- getting #{page} posts ---- "
      doc = Nokogiri::HTML(open("https://nomadphilippines.com/page/#{page}/"))
      
      doc.css('article').each_with_index do |blog,i|
        page = site.pages.new( 
          native_image_url: blog.css('.post-thumbnail img').attr('src'),          
          date_published:  blog.css('.post-date').text.to_date,
          title: blog.css('.post-title').text.squish,
          native_page_url: blog.css('.post-title a').attr('href').value,     
          #summary: blog.css('.entry').text.squish
        ) 
        
        c = blog.css('.post-category').text
        if c == "Special Offers"
          puts "skipping #{c}"
          next
        end
        
        puts "-=-=-=-=-=-=-=-= > getting #{page.title}"
        blog_doc = Nokogiri::HTML(open(page.native_page_url))      
        author = blog_doc.css('.author').text.squish      
        page.author = Author.find_or_create_by(name: author) 
        page.content = blog_doc.css('.entry-inner').to_html
        page.save!
        
        page.categories << Category.find_or_create_by(name: c) if c.present?
      
        binding.pry
      
      end  
    end    
  end
  
  
  
  
  
  desc "Get the blogs and save them in DB "
  task create_key_words: :environment do
    # Read stop words 
    stop_words = []
    File.open("#{Rails.root}/lib/tasks/data/stop_words.txt").each_line do |w|
      stop_words << w.strip
    end  

    stop_yml = YAML::load(File.open("#{Rails.root}/config/stop_words.yml"))

    all_cases = []
    stop_yml['stop_words'].each do |w|
      stop_yml['additional'].each do |a|
        all_cases << "#{w}#{a}"
      end
    end

    Page.limit(10).order('RANDOM()').each do |p|     
      j = p.content.to_plain_text.split.reject{|w| stop_words.include?(w.downcase)}.inject(Hash.new(0)) {|h,v| h[v.downcase] += 1; h; }
      list = j.sort {|a1,a2| a2[1]<=>a1[1]}
      binding.pry
    end
  end

=end  


