require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    @current_user = User.find_by(email: "adminadmino@piyopiyo.com")
    visit new_session_path
    fill_in 'メールアドレス', with: 'adminadmino@piyopiyo.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
  end

  describe '登録機能' do
    context 'ラベルを登録した場合' do
      it '登録したラベルが表示される' do
        visit new_label_path
        fill_in '名前', with: 'らべる'
        click_button '登録する'
        expect(page).to have_content 'らべる'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:first_label) { FactoryBot.create(:first_label, user_id: @current_user.id) }
    context '一覧画面に遷移した場合' do
      it '登録済みのラベル一覧が表示される' do
        visit labels_path
        expect(page).to have_content 'test1'
      end
    end
  end
end