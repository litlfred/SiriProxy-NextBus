SiriProxy-NextBus
=================

NextBus provides up to the minute bus routing information.  See the list of all transit systems with next bus
	http://www.nextbus.com/predictor/agencySelector.jsp

This plugin is defined so that you specify the transit system as well as routes, stops and direction in your config.yml file.  You also specify which regular expressions you want to use to match the incoming text




Sample Config
-------------

	port: 443
	log_level: 1
	plugins:
	    # NOTE: run bundle after changing plugin configurations to update required gems
	    
	  - name: 'NextBus'
	    git: 'git://github.com/litlfred/SiriProxy-NextBus.git

		      
		      
        next_bus:  
	  location: 'chapel-hill' 
	  
          routes:
	    - route: 'NS'
	      stop:  'mannunch'
	      direction: 'N'
	      listeners: ["bus","/when.*next.*northbound.*(tennis|n s|ns|and S).*bus/i","/when.*next.*northboud.*(and|10).*sbus/i", "/when.*next.*(n s|ns).*bus.*(return|home)/i" ]
	      response: "The next NS bus returns in %s minutes"
	      
	      
 	    - route: 'NS'
	      stop:  'airpwest_s'
	      direction: 'S'
      	      listeners: ["/when.*next.*(tennis|n s|ns|and S).*bus/i",  "/when.*next.*(10|and).*sbus/i"]
      	      response: "The next NS bus leaves in %s minutes"
