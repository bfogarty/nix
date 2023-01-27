 self: super: {
   # python310 = super.python310.override {
   #   packageOverrides = python-self: python-super: {
   #     pytest-xdist = python-super.pytest-xdist.overrideAttrs (oldAttrs: rec {
   #       disabledTests = oldAttrs.disabledTests ++ [
   #         "test_max_worker_restart_tests_queued"
   #       ];
   #     });
 
   #     cherrypy = python-super.cherrypy.overrideAttrs (oldAttrs: rec {
   #       dontCheck = true;
   #       # disabledTests = oldAttrs.disabledTests ++ [
   #       #   "test_wait_publishes_periodically"
   #       # ];
   #     });
 
   #     curio = python-super.curio.overrideAttrs (oldAttrs: rec {
   #       disabledTests = oldAttrs.disabledTests ++ ["test_timeout"];
   #     });
   #   };
   # };
 
   python39 = super.python39.override {
     packageOverrides = python-self: python-super: {
       pytest-xdist = python-super.pytest-xdist.overrideAttrs (oldAttrs: rec {
         disabledTests = oldAttrs.disabledTests ++ [
           "test_max_worker_restart_tests_queued"
         ];
       });
     };
   };
 }
