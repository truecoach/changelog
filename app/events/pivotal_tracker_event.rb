class PivotalTrackerEvent < Struct.new(:raw_params)
  def report?
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
