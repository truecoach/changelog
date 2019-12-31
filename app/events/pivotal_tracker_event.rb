class PivotalTrackerEvent < Struct.new(:raw_params)
  BUG = 'bug'.freeze
  FEATURE = 'feature'.freeze

  def report?
    return false unless correct_type?

    accepted? || restarted?
  end

  def story_id
    params.dig('primary_resources', 0, 'id')
  end

  def project_name
    params.dig('project', 'name')
  end

  def restarted?
    return false unless story_updated?

    changeset.dig('original_values', 'current_state') == 'accepted'
  end

  private

  def correct_type?
    [BUG, FEATURE].include?(story_type)
  end

  def story_type
    params.dig('primary_resources', 0, 'story_type')
  end

  def story_updated?
    params['kind'] == 'story_update_activity'
  end

  def changeset
    params.dig('changes', 0) || {}
  end

  def accepted?
    params['highlight'] == 'accepted'
  end

  def params
    memoize { JSON.parse(raw_params.to_json) }
  end
end
