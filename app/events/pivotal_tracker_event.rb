class PivotalTrackerEvent < Struct.new(:raw_params)
  BUG = 'bug'.freeze
  FEATURE = 'feature'.freeze

  def report?
    return false unless correct_type?

    accepted? || restarted?
  end

  def story_id
    primary_story_resource['id']
  end

  def project_name
    params.dig('project', 'name')
  end

  def restarted?
    return false unless story_updated?

    story_changeset.dig('original_values', 'current_state') == 'accepted'
  end

  private

  def correct_type?
    [BUG, FEATURE].include?(story_type)
  end

  def story_type
    primary_story_resource['story_type']
  end

  def primary_story_resource
    memoize do
      primary_resources = params['primary_resources'] || []

      primary_resource = primary_resources.detect { |r| r['kind'] == 'story' } || {}
    end
  end

  def story_updated?
    params['kind'] == 'story_update_activity'
  end

  def story_changeset
    changes = params['changes'] || []

    changes.detect { |c| c['kind'] == 'story' } || {}
  end

  def accepted?
    params['highlight'] == 'accepted'
  end

  def params
    memoize { JSON.parse(raw_params.to_json) }
  end
end
