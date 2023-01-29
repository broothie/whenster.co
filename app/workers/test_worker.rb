class TestWorker
  include Cloudtasker::Worker

  def perform
    logger.info "test worker!!"
  end
end
