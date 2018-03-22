module Fountain
  module Api
    #
    # Fountain Applicant API
    #
    class Applicants
      include RequestHelper

      #
      # List applicants
      # @param [Hash] filter_options A hash of options to send to Fountain.
      #                 funnel_id - Unique identifier of the position/funnel
      #                 stage_id - Unique identifier of the stage
      #                 stage - Filter applicants by stage type
      #                 labels - MUST be URL-encoded
      #                 cursor - Cursor parameter for cursor-based pagination
      # @return [Array] of Fountain::Applicant
      def list(filter_options = {})
        response = request_json(
          '/v2/applicants',
          body: Util.slice_hash(
            filter_options,
            :funnel_id, :stage_id, :stage, :labels, :cursor
          )
        )
        Fountain::Applicants.new response
      end

      #
      # Create an Applicant
      # @param [String] name Full name of the applicant
      # @param [String] email Email address of the applicant
      # @param [String] phone_number Phone number (does not have to be USA)
      # @param [Hash] create_options A hash of optional parameters
      #                 data - must be passed in a data object/array
      #                 secure_data - See 'Secure Fields' section of
      #                               https://developer.fountain.com/docs/post-apiv2applicants
      #                 funnel_id - Create applicant under a certain opening (funnel)
      #                 stage_id - Create applicant under a certain stage
      #                 skip_automated_actions - `true` if you want to skip automated
      #                                          actions when advancing the applicant
      # @return [Fountain::Applicant]
      def create(name, email, phone_number, create_options = {})
        filtered_params = Util.slice_hash(
          create_options,
          :data, :secure_data, :funnel_id, :stage_id, :skip_automated_actions
        )
        response = request_json(
          '/v2/applicants',
          method: :post,
          body: {
            name: name, email: email, phone_number: phone_number
          }.merge(filtered_params)
        )
        Fountain::Applicant.new response
      end

      #
      # Delete an Applicant
      # @param [String] applicant_id ID of the Fountain applicant
      # @return [Boolean]
      def delete(applicant_id)
        response = request(
          "/v2/applicants/#{applicant_id}",
          method: :delete
        )
        check_response response
        true
      end

      #
      # Update Applicant Info
      # @param [String] applicant_id ID of the Fountain applicant
      # @param [Hash] update_options A hash of options to update applicant
      #                 name
      #                 email
      #                 phone_number
      #                 data - must be passed in a data object/array
      #                 secure_data - See 'Secure Fields' section of
      #                               https://developer.fountain.com/docs/update-applicant-info
      #                 rejection_reason
      #                 on_hold_reason
      # @return [Fountain::Applicant]
      #
      def update(applicant_id, update_options = {})
        response = request_json(
          "/v2/applicants/#{applicant_id}",
          method: :put,
          body: Util.slice_hash(
            update_options,
            :name, :email, :phone_number, :data, :secure_data,
            :rejection_reason, :on_hold_reason
          )
        )
        Fountain::Applicant.new response
      end
    end
  end
end
