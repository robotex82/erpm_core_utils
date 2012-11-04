module ERPM
  module Links
    class Routing
      def self.routes(router, options = {})
        options.reverse_merge! {}

        # router.resources :posts, :controller => 'erpm/core_utils/posts'
      end
    end
  end
end

