Rails.application.config.middleware.use OmniAuth::Builder do
 # provider :facebook, "472181629493050", "5bea354902b81bcf9f572f9b45ceec69", 
#					{client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}


provider :facebook, "135187446628246", "de243579d2f13202fecf7d3d3e74d597", 
					{client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
					
  end