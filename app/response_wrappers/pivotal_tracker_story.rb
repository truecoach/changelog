class PivotalTrackerStory < Struct.new(:issue)
  BUG = 'bug'.freeze

  def url
    issue['url']
  end

  def project_name
    issue.dig('project', 'name')
  end

  def name
    issue['name']
  end

  def type
    issue['story_type']
  end

  def labels
    memoize { issue['labels'].map { |l| l['name'] }.join(', ') }
  end

  def description
    issue['description'] || '-'
  end

  def error?
    kind == 'error'
  end

  def bug?
    BUG == type
  end

  def kind
    issue['kind']
  end
end
