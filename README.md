SiriProxy-NextBus
=================

NextBus provides up to the minute bus routing information.  See the list of all transit systems with next bus
	http://www.nextbus.com/predictor/agencySelector.jsp


Sample Config
-------------

	port: 443
	log_level: 1
	plugins:
	    # NOTE: run bundle after changing plugin configurations to update required gems
	    
	        - name: 'NextBus'
		      path: './plugins/siriproxy-nextbus'
		      
		      
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
