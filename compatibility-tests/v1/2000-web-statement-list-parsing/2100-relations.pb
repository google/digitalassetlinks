# All the test cases in this group cover parsing of statement lists on web
# assets (i.e., inside of .well-known/assetlinks.json files).  Specifically, this
# file contains tests specific to parsing of the relation string.

test_group: {
  name: 'comptest2101: valid relation string in statement lists (1)'

  web_content: {
    url: 'https://source-comptest2101.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2101.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2101.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-comptest2101.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-comptest2101.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest2102: valid relation string in statement lists (2)'

  web_content: {
    url: 'https://source-comptest2102.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2102.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2102.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-comptest2102.digitalassetlinks.org." } }
      relation: "delegate_permission/write_on_the_walls"
      target { web { site: "https://target-comptest2102.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest2103: valid relation string in statement lists (3)'

  web_content: {
    url: 'https://source-comptest2103.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/org.digitalassetlinks.write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2103.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2103.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-comptest2103.digitalassetlinks.org." } }
      relation: "delegate_permission/org.digitalassetlinks.write_on_the_walls"
      target { web { site: "https://target-comptest2103.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest2104: valid relation string in statement lists (4)'

  web_content: {
    url: 'https://source-comptest2104.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["navigate/yellow_brick_road"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2104.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2104.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-comptest2104.digitalassetlinks.org." } }
      relation: "navigate/yellow_brick_road"
      target { web { site: "https://target-comptest2104.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest2105: valid relation string in statement lists (5)'

  web_content: {
    url: 'https://source-comptest2105.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/get_login_creds"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2105.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2105.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-comptest2105.digitalassetlinks.org." } }
      relation: "delegate_permission/get_login_creds"
      target { web { site: "https://target-comptest2105.digitalassetlinks.org." } }
    }
  }
}

# Now some invalid queries.
test_group: {
  name: 'comptest2106: missing relation string in statement list'

  web_content: {
    url: 'https://source-comptest2106.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{ "target" : { "namespace": "web", "site": "https://target-comptest2106.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2106.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no relation array specified'
  }
}

test_group: {
  name: 'comptest2107: Relation must be non-empty'
  web_content: {
    url: 'https://source-comptest2107.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": [""], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2107.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2107.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
  }
}

test_group: {
  name: 'comptest2108: relations must be given as an array'
  web_content: {
    url: 'https://source-comptest2108.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": "delegate_permission/common.handle_all_urls", '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2108.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2108.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not an array'
  }
}

test_group: {
  name: 'comptest2109: individual relations must be strings'
  web_content: {
    url: 'https://source-comptest2109.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": [ {} ], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2109.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2109.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid relation'
  }
}

test_group: {
  name: 'comptest2110: relations must not have wildcards'
  web_content: {
    url: 'https://source-comptest2110.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/*"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2110.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2110.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }
}

test_group: {
  name: 'comptest2111: relation string with invalid kind (1)'
  web_content: {
    url: 'https://source-comptest2111.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["INVALID_KIND/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2111.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2111.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }
}

test_group: {
  name: 'comptest2112: relation string with invalid kind (2)'
  web_content: {
    url: 'https://source-comptest2112.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2112.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2112.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }
}

test_group: {
  name: 'comptest2113: relation string with invalid kind (3)'
  web_content: {
    url: 'https://source-comptest2113.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["/"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2113.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2113.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }
}

test_group: {
  name: 'comptest2114: invalid relation string (1)'
  web_content: {
    url: 'https://source-comptest2114.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2114.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2114.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
  }
}

test_group: {
  name: 'comptest2115: invalid relation string (2)'
  web_content: {
    url: 'https://source-comptest2115.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2115.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2115.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
  }
}

test_group: {
  name: 'comptest2116: invalid relation string (3)'
  web_content: {
    url: 'https://source-comptest2116.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/write_on_the_walls/foo"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2116.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2116.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
  }
}

test_group: {
  name: 'comptest2117: invalid relation string (4)'
  web_content: {
    url: 'https://source-comptest2117.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission,write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2117.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2117.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
  }
}

test_group: {
  name: 'comptest2118: relation string with invalid detail (1)'
  web_content: {
    url: 'https://source-comptest2118.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2118.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2118.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }
}

test_group: {
  name: 'comptest2119: relation string with invalid detail (2)'
  web_content: {
    url: 'https://source-comptest2119.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/write on the walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2119.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2119.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }
}

test_group: {
  name: 'comptest2120: relation string with invalid detail (3)'
  web_content: {
    url: 'https://source-comptest2120.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/write+on+the+walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2120.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2120.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }
}

test_group: {
  name: 'comptest2121: relation string with invalid detail (4)'
  web_content: {
    url: 'https://source-comptest2121.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/write_on_the_walls!"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2121.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2121.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }
}

test_group: {
  name: 'comptest2122: relation string with invalid detail (5)'
  web_content: {
    url: 'https://source-comptest2122.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/write_on_the_WALLS"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2122.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2122.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }
}

test_group: {
  name: 'comptest2123: relation string with spurious whitespace (1)'
  web_content: {
    url: 'https://source-comptest2123.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/write_on_the_walls "], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2123.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2123.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }
}

test_group: {
  name: 'comptest2124: relation string with spurious whitespace (2)'
  web_content: {
    url: 'https://source-comptest2124.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": [" delegate_permission/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2124.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2124.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }
}

test_group: {
  name: 'comptest2125: relation string with spurious whitespace (3)'
  web_content: {
    url: 'https://source-comptest2125.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission / write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2125.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2125.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }
}
