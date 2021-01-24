node gitlab.local {
  class { 'gitlab':
    external_url => 'http://gitlab.local',
  }
}
