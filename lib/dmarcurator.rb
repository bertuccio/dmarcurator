# frozen_string_literal: true

require 'dmarcurator/version'

module Dmarcurator
  require 'dmarcurator/cli/app'
  require 'dmarcurator/print_reports'
  require 'dmarcurator/parser'
  require 'dmarcurator/parser/base'
  require 'dmarcurator/parser/record'
  require 'dmarcurator/parser/report'
  require 'dmarcurator/print/record'
  require 'dmarcurator/print/report'
end
