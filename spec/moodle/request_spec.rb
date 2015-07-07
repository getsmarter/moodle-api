require 'spec_helper'

module Moodle
  RSpec.describe Request do
    let(:path) { 'http://dev.vle.getsmarter.co.za/webservice/rest/server.php' }
    let(:headers) { { 'Accept' => "json" } }

    context 'external service' do
      let(:params) do
        { 'criteria[0][key]' => 'firstname',
          'criteria[0][value]' => 'Jon',
          'moodlewsrestformat' => 'json',
          'wsfunction' => 'core_user_get_users',
          'wstoken' => '072556801bf07076fff6bff2a463b7c5' }
      end

      it 'calls the web service requested' do
        VCR.use_cassette('external_service/valid_service') do
          expected_response = {"users"=>[{"id"=>5329, "username"=>"ryan.mes@email.co.za", "firstname"=>"Jon", "lastname"=>"Snow", "fullname"=>"Jon Snow", "email"=>"ryan.mes@email.co.za", "department"=>"", "firstaccess"=>1385623936, "lastaccess"=>1435753716, "description"=>"", "descriptionformat"=>1, "city"=>"Cape Town", "profileimageurlsmall"=>"http://dev.vle.getsmarter.co.za/pluginfile.php/46751/user/icon/f2", "profileimageurl"=>"http://dev.vle.getsmarter.co.za/pluginfile.php/46751/user/icon/f1", "customfields"=>[{"type"=>"text", "value"=>"GetSmarter", "name"=>"Company", "shortname"=>"company"}, {"type"=>"text", "value"=>"www.getsmarter.co.za", "name"=>"Company Website", "shortname"=>"companywebsite"}, {"type"=>"text", "value"=>"Lead Developer", "name"=>"Position", "shortname"=>"position"}, {"type"=>"textarea", "value"=>"<p>I am an avid adventure racer!</p>", "name"=>"More about me", "shortname"=>"moreaboutme"}, {"type"=>"menu", "value"=>"Short Course", "name"=>"Enrolled in ", "shortname"=>"programme"}, {"type"=>"datetime", "value"=>"0", "name"=>"Date of birth", "shortname"=>"dateofbirth"}, {"type"=>"text", "value"=>"Jon", "name"=>"Certificate First Name", "shortname"=>"certificatefirstname"}, {"type"=>"text", "value"=>"Snow", "name"=>"Certificate Last Name", "shortname"=>"certificatelastname"}, {"type"=>"text", "value"=>"8402025278086", "name"=>"Identification Number", "shortname"=>"id"}, {"type"=>"text", "value"=>"Kingsbury Court", "name"=>"Address Line 1", "shortname"=>"addressline1"}, {"type"=>"text", "value"=>"13 Rouwkoop Rd", "name"=>"Address Line 2", "shortname"=>"addressline2"}, {"type"=>"text", "value"=>"Rondebosch", "name"=>"Suburb", "shortname"=>"suburb"}, {"type"=>"text", "value"=>"Cape Town", "name"=>"City", "shortname"=>"city"}, {"type"=>"text", "value"=>"7700", "name"=>"Postal Code", "shortname"=>"postalcode"}, {"type"=>"text", "value"=>"Western Cape", "name"=>"Province", "shortname"=>"province"}, {"type"=>"text", "value"=>"South Africa", "name"=>"Country", "shortname"=>"country"}, {"type"=>"menu", "value"=>"No", "name"=>"Certificate names checked", "shortname"=>"certificatenameschecked"}], "preferences"=>[{"name"=>"auth_manual_passwordupdatetime", "value"=>"1434626773"}, {"name"=>"block7hidden", "value"=>"0"}, {"name"=>"block9hidden", "value"=>"0"}, {"name"=>"docked_block_instance_7", "value"=>"0"}, {"name"=>"docked_block_instance_9", "value"=>"0"}, {"name"=>"email_bounce_count", "value"=>"0"}, {"name"=>"email_send_count", "value"=>"41"}, {"name"=>"filepicker_recentlicense", "value"=>"allrightsreserved"}, {"name"=>"filepicker_recentrepository", "value"=>"7"}, {"name"=>"htmleditor", "value"=>""}, {"name"=>"login_failed_count_since_success", "value"=>"7"}, {"name"=>"message_beepnewmessage", "value"=>"0"}, {"name"=>"message_blocknoncontacts", "value"=>"0"}, {"name"=>"message_provider_enrol_manual_expiry_notification_loggedin", "value"=>"email"}, {"name"=>"message_provider_enrol_manual_expiry_notification_loggedoff", "value"=>"email"}, {"name"=>"message_provider_enrol_self_expiry_notification_loggedin", "value"=>"email"}, {"name"=>"message_provider_enrol_self_expiry_notification_loggedoff", "value"=>"email"}, {"name"=>"message_provider_mod_assign_assign_notification_loggedin", "value"=>"email"}, {"name"=>"message_provider_mod_assign_assign_notification_loggedoff", "value"=>"email"}, {"name"=>"message_provider_mod_forum_posts_loggedin", "value"=>"email"}, {"name"=>"message_provider_mod_forum_posts_loggedoff", "value"=>"email"}, {"name"=>"message_provider_mod_lesson_graded_essay_loggedin", "value"=>"email"}, {"name"=>"message_provider_mod_lesson_graded_essay_loggedoff", "value"=>"email"}, {"name"=>"message_provider_mod_quiz_attempt_overdue_loggedin", "value"=>"email"}, {"name"=>"message_provider_mod_quiz_attempt_overdue_loggedoff", "value"=>"email"}, {"name"=>"message_provider_mod_quiz_confirmation_loggedin", "value"=>"email"}, {"name"=>"message_provider_mod_quiz_confirmation_loggedoff", "value"=>"email"}, {"name"=>"message_provider_mod_quiz_submission_loggedin", "value"=>"email"}, {"name"=>"message_provider_mod_quiz_submission_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_availableupdate_loggedin", "value"=>"email"}, {"name"=>"message_provider_moodle_availableupdate_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_backup_loggedin", "value"=>"email"}, {"name"=>"message_provider_moodle_backup_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_badgecreatornotice_loggedin", "value"=>"none"}, {"name"=>"message_provider_moodle_badgecreatornotice_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_badgerecipientnotice_loggedin", "value"=>"popup"}, {"name"=>"message_provider_moodle_badgerecipientnotice_loggedoff", "value"=>"popup,email"}, {"name"=>"message_provider_moodle_courserequestapproved_loggedin", "value"=>"email"}, {"name"=>"message_provider_moodle_courserequestapproved_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_courserequested_loggedin", "value"=>"email"}, {"name"=>"message_provider_moodle_courserequested_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_courserequestrejected_loggedin", "value"=>"email"}, {"name"=>"message_provider_moodle_courserequestrejected_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_errors_loggedin", "value"=>"email"}, {"name"=>"message_provider_moodle_errors_loggedoff", "value"=>"email"}, {"name"=>"message_provider_moodle_instantmessage_loggedin", "value"=>"popup"}, {"name"=>"message_provider_moodle_instantmessage_loggedoff", "value"=>"popup,email"}, {"name"=>"message_provider_moodle_notices_loggedin", "value"=>"email"}, {"name"=>"message_provider_moodle_notices_loggedoff", "value"=>"email"}, {"name"=>"userselector_autoselectunique", "value"=>"0"}, {"name"=>"userselector_optionscollapsed", "value"=>"0"}, {"name"=>"userselector_preserveselected", "value"=>"1"}, {"name"=>"userselector_searchanywhere", "value"=>"0"}, {"name"=>"_lastloaded", "value"=>1435753952}]}], "warnings"=>[]}
          response = Moodle::Request.new.post(path, params: params, headers: headers)
          expect(response).to eq(expected_response)
        end
      end

      it 'raises moodle error if incorrect method name is used' do
        # add params that are required
        params['wsfunction'] ='core_user_get_users_invalid'

        VCR.use_cassette('external_service/invalid_service') do
          expect {
            response = Moodle::Request.new.post(path, params: params, headers: headers)
          }.to raise_error(Moodle::MoodleError, "Can not find data record in database table external_functions.")
        end
      end

      it 'raises moodle error if trying to access method that has not been made external' do
        VCR.use_cassette('external_service/valid_service_not_external') do
          expect {
            response = Moodle::Request.new.post(path, params: params, headers: headers)
          }.to raise_error(Moodle::MoodleError, "Access control exception")
        end
      end

      it 'returns empty array when no data is returned' do
        # remove params not required
        params.delete('criteria[0][key]')
        params.delete('criteria[0][value]')

        # add params that are required
        params['wsfunction'] = 'local_getsmarter_get_quiz_grades'
        params['courseid'] = '92'

        VCR.use_cassette('external_service/valid_service_empty_array_response') do
          response = Moodle::Request.new.post(path, params: params, headers: headers)
          expect(response).to match_array([])
        end
      end
    end
  end
end
