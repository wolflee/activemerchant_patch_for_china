require File.dirname(__FILE__) + '/baofoo/helper.rb'
require File.dirname(__FILE__) + '/baofoo/return.rb'
require File.dirname(__FILE__) + '/baofoo/notification.rb'
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Baofoo
        mattr_accessor :service_url
        self.service_url = 'http://paytest.baofoo.com/PayReceive/umpaysend.aspx'

        def self.notification(post)
          Notification.new(post)
        end  

        def self.return(query_string)
          Return.new(query_string)
        end 
      end
    end
  end
end
