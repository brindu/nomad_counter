require 'rails_helper'

describe 'create an event from a slack post' do
  let!(:post) { create(:slack_post, :remaining) }

  before do
    visit slack_posts_path
    within("#slack_post_#{post.id}") do
      click_button('add_event')
    end
  end

  it 'redirects to the form to create a new event' do
    expect(page).to have_current_path(new_slack_post_event_path(post))
  end

  it 'sets the associated slack post id in hidden field' do
    expect(page).to have_css("input[value='#{post.id}'][name='event[slack_post_id]']", visible: false)
  end

  subject(:submit!) do
    within('#new_event') do
      click_button 'commit'
    end
  end

  let(:start_time) { Faker::Time.forward(days: 5) }

  context 'with a valid start time' do
    before do
      within('#new_event') do
        fill_in 'event_title', with: 'Much event'
        select start_time.year, from: 'event_start_time_1i'
        select Date::MONTHNAMES[start_time.month], from: 'event_start_time_2i'
        select start_time.day, from: 'event_start_time_3i'
        select start_time.hour, from: 'event_start_time_4i', match: :first
        select start_time.min, from: 'event_start_time_5i'
      end
    end

    let(:created_event) { Event.last }

    context 'without a specified end date' do
      it 'creates an event' do
        submit!

        expect(created_event.title).to eq('Much event')
        expect(created_event.start_time.strftime('%F %H:%M')).to eq(start_time.strftime('%F %H:%M'))
      end

      it 'sets the end date to nil' do
        submit!

        expect(created_event.end_time).to be_nil
      end
    end

    context 'with a specified end date' do
      before do
        within('#new_event') do
          fill_in 'event_title', with: 'Much event'
          select end_time.year, from: 'event_end_time_1i'
          select Date::MONTHNAMES[end_time.month], from: 'event_end_time_2i'
          select end_time.day, from: 'event_end_time_3i'
          select end_time.hour, from: 'event_end_time_4i'
          select end_time.min, from: 'event_end_time_5i'
        end

        let(:end_time) { Faker::Time.forward(days: 5) }

        it 'creates an event' do
          submit!

          expect(created_event.title).to eq('Much event')
          expect(created_event.end_time.strftime('%F %H:%M')).to eq(end_time.strftime('%F %H:%M'))
          expect(created_event.end_time.strftime('%F %H:%M')).to eq(end_time.strftime('%F %H:%M'))
        end
      end
    end
  end
end
