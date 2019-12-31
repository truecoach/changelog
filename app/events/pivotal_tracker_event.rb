class PivotalTrackerEvent < Struct.new(:raw_params)
  def report?
    accepted?
  end

  def story_id
    params.dig('primary_resources', 0, 'id')
  end

  def project_name
    params.dig('project', 'name')
  end

  private

  def accepted?
    params['highlight'] == 'accepted'
  end

  def params
    memoize { JSON.parse(raw_params.to_json) }
  end
end
