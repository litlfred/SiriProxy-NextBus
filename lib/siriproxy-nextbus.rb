require 'cora'
require 'siri_objects'
require 'nokogiri'
require 'open-uri'

#######
# Queries Chapel Hill's next bus service
######

class SiriProxy::Plugin::NextBus < SiriProxy::Plugin


  #redundant: this is defined in my custom plungin manage siriproxypm-clientcachestae
  def get_app_config(*args)
    result = $APP_CONFIG
    if args != nil \
      && (first_arg = args.shift) != nil 
      eval "result = result.#{first_arg}"
      args.each do |arg|
        if arg == nil \
          || result  == nil \
          || !result.respond_to?('has_key?')\
          || !result.has_key?(arg)
          result = nil
          break
        end          
        result = result[arg]
      end
    end
    return result
  end

  #redundant:  this is defined in my custom plungin manage siriproxypm-clientcachestate
  def ensure_regexp(regexp) 
    if regexp != nil
      regexp.is_a?(String) 
      if regexp[0] == '/'
        #try to make it into a regexp
        regexp = eval regexp
      elsif  
        regexp = Regexp.new("^\s*#{regexp}",true);
      end
    end
    if regexp == nil || !regexp.is_a?(Regexp)
      regexp = nil
    end
    return regexp
  end

  def add_listeners(regexps,options= {},&block) 
    if regexps == nil 
      return
    end
    if !regexps.respond_to?('each') 
      #may be a scalar value
      regexps = [regexps]
    end
    regexps.each do |regexp|
      if (regexp = ensure_regexp(regexp)) == nil \
        || !regexp.is_a?(Regexp)
        next
      end
      listeners[regexp] = {:block => block,   within_state: ([options[:within_state]].flatten)}
    end
  end

  def initialize(config)
    location = get_app_config("next_bus","location")
    if location == nil  || !location.is_a?(String)
      return
    end
    buses = get_app_config("next_bus","routes")
    if buses != nil \
      && buses.respond_to?('each')
      buses.each do |bus_data|
        if bus_data == nil \
          || !bus_data.respond_to?('has_key?') 
          next
        end
        route = bus_data["route"]
        response = bus_data["response"]
        stop = bus_data["stop"]
        direction = bus_data["direction"]
        listeners = bus_data["listeners"]
        if route == nil || stop == nil || direction == nil || listeners == nil 
          next
        end
        add_listeners(listeners) {show_next_bus(route,direction,stop,response)}
      end
    end
  end
  


  def show_next_bus(route,direction,stop,response)
    say "Let me check" 
    minutes = get_next_bus(route,direction,stop)
    if minutes  == nil || !minutes.is_a?(String)
      say "Sorry. I could not find the next bus information"
    else
      if response == nil || !response.is_a?(String)
        reponse = "The next #{route} bus is in %s minutes"
      end
      response = sprintf(response,minutes.strip)
      say response
    end
    request_completed
  end

  def get_next_bus(route,direction,stop) 
    url = "http://www.nextbus.com/predictor/fancyBookmarkablePredictionLayer.shtml?a=chapel-hill&r=#{route}&d=#{direction}&s=#{stop}"
    path = "//td[@class='predictionNumberForFirstPred']"
    return scrape_url(url,path)
  end

  def scrape_url(url,path)
    log "Scraping #{url}"
    result = false
    doc = Nokogiri::HTML(open(url))
    doc.xpath(path).each do |node|
      result = node.content
      break
    end
    log "Scraped #{result}"
    return result
  end
  



end
