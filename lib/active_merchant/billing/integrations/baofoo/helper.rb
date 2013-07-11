require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Baofoo
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :account, 'MerchantID'
          mapping :amount, 'OrderMoney'
          mapping :currency, 'currency'
          mapping :order, 'TransID'
          mapping :return_url, 'Return_url'
          mapping :notify_url, 'Merchant_url'
          mapping :description, 'ProductName'
          mapping :channel, 'PayID'

          def initialize(order, account, options = {})
            super(order, ACCOUNT, options)
            #add_field('version_id', '2.00')
            #add_field('pc_id', '') # Keep empty if pm_id is empty
            add_field('Amount', 1)
            add_field('ProductLogo', '')
            add_field('Username', '')
            add_field('Email', '')
            add_field('Mobile', options['phone'])
            add_field('AdditionalInfo', '')
            add_field('NoticeType', 0)
            add_field('TradeDate', DateTime.now.strftime("%Y%m%d%H%M%S"))
          end

          def form_fields
            @fields.merge('Md5Sign' => sign)
          end

          def sign
            Digest::MD5.hexdigest(%w(MerchantID PayID TradeDate TransID OrderMoney 
                                     Merchant_url Return_url NoticeType).collect{
                |name| "#{@fields[name]}"
              }.join('') + "#{KEY}")
          end

        end
      end
    end
  end
end
