class PivotalTrackerWebhookHandler < Struct.new(:params)
  def save
    return true unless event.report?

    SlackNotifier.call(slack_changelog_entry)
  end

  private

  def slack_changelog_entry
    SlackFormatter.call(
      type: story.type,
      identifier: event.project_name,
      title: story.name,
      description: story.description,
      labels: story.labels,
      url: story.url,
      show_as_bug: story.bug?,
      is_rolledback: event.restarted?
    )
  end

  def story
    memoize { PivotalTrackerClient.story(event.story_id) }
  end

  def event
    memoize { PivotalTrackerEvent.new(params) }
  end
end
