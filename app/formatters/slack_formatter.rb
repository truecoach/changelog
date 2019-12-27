class SlackFormatter
  def self.call(*args)
    new(*args).call
  end

  def initialize(params)
    self.type = params.fetch(:type)
    self.title = params.fetch(:title)
    self.identifier = params.fetch(:identifier)
    self.description = params.fetch(:description)
    self.labels = params.fetch(:labels, '')
    self.url = params.fetch(:url)
    self.show_as_bug = params.fetch(:show_as_bug, false)
  end

  def call
    <<~MSG
      -----------------------
      #{emoji} deployed by #{identifier} @ #{Time.now.strftime('%-d-%-m-%y %-k:%M %Z')}
      \n
      *[#{type}]* #{title}
      *description:* #{summary}
      *labels:* #{labels}
      \n
      #{url}
    MSG
  end

  private

  attr_accessor :description,
                :labels,
                :identifier,
                :show_as_bug,
                :title,
                :type,
                :url

  def summary
    shortened_desc = description[0..200]
    shortened_desc += '...' if description.length > shortened_desc.length
  end

  def emoji
    show_as_bug ? ':hammer_and_wrench:' : ':evergreen_tree:'
  end
end
