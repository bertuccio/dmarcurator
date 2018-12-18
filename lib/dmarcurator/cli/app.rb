# frozen_string_literal: true

module Dmarcurator
  module Cli
    class App
      require 'pry'

      attr_reader :output_path, :reports_path

      def self.main
        params = parse_options(ARGV)
        new(params).run
      end

      def self.parse_options(options)
        params = {}

        opt_parser = OptionParser.new do |parser|
          parser.banner = "dmarcurator parses DMARC reports and stores them into a file.\nIt can also serve a basic web UI for viewing reports (-ui=true).\nUsage: dmarcurator [options]"

          parser.on('-o', '--output=FILE', 'Path to output file. (e.g. ./tmp/reports.txt)') do |value|
            params[:output_path] = value
          end

          parser.on('-rp', '--reports-path=REPORTS_PATH', 'Path to directory containing DMARC reports. (e.g. ./tmp/reports/)') do |value|
            params[:reports_path] = value
          end

          parser.on('-h', '--help', 'Halp pls') do
            puts parser
            exit 0
          end

          parser.on('-v', '--version', 'Print version') do
            puts ::Dmarcurator::VERSION
            exit 0
          end

          if options.empty?
            puts parser
            exit 1
          end
        end

        opt_parser.parse!(options)
        if !params[:reports_path]
          puts 'Dmarcurator can parse DMARC reports into a readable file -> Set --o and --reports-path)'
          exit 0
        end

        params
      end

      def initialize(output_path: nil, reports_path: nil)
        @output_path = output_path
        @reports_path = reports_path
      end

      def run
        return unless reports_path
        ::Dmarcurator::PrintReports.new(output: output_path, reports_path: reports_path).run
      end
    end
  end
end
