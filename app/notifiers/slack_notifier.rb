class SlackNotifier < Struct.new(:message)
  def self.call(*args)
    new(*args).call
  end

  def call
    notifier.ping(message)
  end

  private

  def notifier
    memoize { Slack::Notifier.new(ENV.fetch('SLACK_INCOMING_WEBHOOK_URL')) }
  end
end
