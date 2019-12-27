class PivotalTrackerClient
  class << self
    def story(id)
      story = HTTParty.get(story_url(id), headers: headers)

      PivotalTrackerStory.new(story)
    end

    private

    def story_url(story_id)
      service_url('stories', story_id.to_s)
    end

    def service_url(*args)
      URI::HTTPS.build(
        host: 'www.pivotaltracker.com',
        path: File.join('/services/v5/', *args)
      ).to_s
    end

    def headers
      { 'X-TrackerToken' => ENV.fetch('PIVOTAL_TRACKER_API_TOKEN') }
    end
  end
end
