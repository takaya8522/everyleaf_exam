require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  describe '登録機能' do
    context 'ユーザを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in '名前', with: 'ハム太郎'
        fill_in 'メールアドレス', with: 'hamuhamu@hamuhamu.com'
        fill_in 'パスワード', with: '123456'
        fill_in 'パスワード（確認）', with: '123456'
        click_button '登録する'
        expect(page).to have_content 'タスク一覧ページ'
      end
    end
    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end
  describe 'ログイン機能' do
    let!(:first_user) { FactoryBot.create(:first_user) }
    let!(:first_user) { FactoryBot.create(:first_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'piyopiyo@piyopiyo.com'
      fill_in 'パスワード', with: '123456'
    end

    context '登録済みのユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content 'ログインしました'
      end

      it '自分の詳細画面にアクセスできる' do
        visitor users_path(first_user.id)
        expect(page).to have_content 'piyopiyo'
      end

      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        visitor users_path(2)
        expect(page).to have_content 'タスク一覧ページ'
      end
      
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理者機能' do
    let!(:second_user) { FactoryBot.create(:second_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'piyopiyotaro@piyopiyo.com'
      fill_in 'パスワード', with: '123456'
    end

    context '管理者がログインした場合' do
      it 'ユーザ一覧画面にアクセスできる' do
        click_link 'ユーザ一覧ページ'
        expect(page).to have_content 'ユーザ一覧ページ'
      end

      it '管理者を登録できる' do
        click_link 'ユーザを登録する'
        expect(page).to have_content 'ユーザ登録ページ'
      end

      it 'ユーザ詳細画面にアクセスできる' do
        click_link 'ユーザ一覧ページ'
        click_link '詳細'
        expect(page).to have_content 'ユーザ詳細ページ'
      end

      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        click_link 'ユーザ一覧ページ'
        click_link '編集'
        expect(page).to have_content 'ユーザ編集ページ'
      end

      it 'ユーザを削除できる' do
        click_link 'ユーザ一覧ページ'
        click_link '削除'
        expect(page).to have_content 'アカウントを削除しました'
      end
    end

    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      let!(:first_user) { FactoryBot.create(:first_user) }

      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'piyopiyo@piyopiyo.com'
        fill_in 'パスワード', with: '123456'
        visit admin_users_path
        expect(page).to have_content '管理者以外アクセスできません'
      end
    end
  end
end