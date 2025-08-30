module Tailscale
  class Down < Command
    def new
      super unless Status.stopped?
    end
  end

  def success?
    Status.stopped?
  end
end
