module ResqueWeb
  class WorkersController < ResqueWeb::ApplicationController
    before_action :display_subtabs

    def index
    end

    def show
      if params[:id] && params[:id] != 'all'
        @workers = view_context.worker_hosts[params[:id]].map { |id| Resque::Worker.find(id) }
      else
        @workers = Resque.workers
      end
    end

    def kill_worker
      Resque::Worker.find(params[:id]).unregister_worker
      redirect_to overview_path
    end

    private

    def display_subtabs
      set_subtabs view_context.worker_hosts.map(&:first)
    end

  end
end
