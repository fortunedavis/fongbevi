class FileDownloaderJob < ApplicationJob
  queue_as :default

  def perform(all)
    attributes = %w{sentence audio}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |clip|
        csv << clip.attributes.values_at(*attributes)
      end
    end
  end
end