Deface::Override.new(:virtual_path => 'spree/shared/_filters',
                     :name => "remove_price_range_from_productts_page",
                     :replace => "erb[silent]:contains('filters =')",
                     :text => "<% filters = [] %>"  
                    )
