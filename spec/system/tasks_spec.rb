require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    @current_user = User.find_by(email: "adminadmino@piyopiyo.com")
    visit new_session_path
    fill_in 'メールアドレス', with: 'adminadmino@piyopiyo.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
  end
  
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル', with: '書類作成'
        fill_in '内容', with: '企画書を作成する'
        fill_in "task[deadline_on]", with: "002019-11-11"
        select '低', from: 'task_priority'
        select '未着手', from: 'task_status'
        click_button '登録する'
        expect(page).to have_content '書類作成'
      end
    end
  end

  describe '一覧表示機能' do
    # let!を使ってテストデータを変数として定義することで、複数のテストでテストデータを共有できる
    let!(:first_task) { FactoryBot.create(:first_task, title: 'task_title1', user_id: @current_user.id) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'task_title2', user_id: @current_user.id) }
    let!(:third_task) { FactoryBot.create(:third_task, title: 'task_title3', user_id: @current_user.id) }
    let(:forth_task) { FactoryBot.create(:task, user_id: @current_user.id) }
    # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
    before do
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        task_list = all('body tr')
        expect(task_list[1].text).to have_content 'task_title1'
        expect(task_list[2].text).to have_content 'task_title2'
        expect(task_list[3].text).to have_content 'task_title3'
      end
    end

    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        task = forth_task.title
        visit tasks_path
        task_list = all('body tr')
        expect(task_list[1].text).to have_content '書類作成'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        @task = FactoryBot.create(:task, user_id: @current_user.id)
        visit tasks_path(@task)
        expect(page).to have_content '書類作成'
      end
    end
  end

  describe 'ソート機能' do
    let!(:first_task) { FactoryBot.create(:first_task, title: 'first_task_title', user_id: @current_user.id) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'second_task_title', user_id: @current_user.id) }
    let!(:third_task) { FactoryBot.create(:third_task, title: 'third_task_title', user_id: @current_user.id) }
    before do
      visit tasks_path
    end

    context '「終了期限でソートする」というリンクをクリックした場合' do
      it "終了期限昇順に並び替えられたタスク一覧が表示される" do
        # allメソッドを使って複数のテストデータの並び順を確認する
        click_link '終了期限'
        task_list = all('tbody tr')
        expect(task_list[0].text).to have_content 'first_task_title'
        # expect(task_list[1].text).to have_content 'second_task_title'
        # expect(task_list[3].text).to have_content 'third_task_title'
      end
    end
    context '「優先度でソートする」というリンクをクリックした場合' do
      it "優先度の高い順に並び替えられたタスク一覧が表示される" do
        # allメソッドを使って複数のテストデータの並び順を確認する
        click_link '優先度'
        task_list = all('tbody tr')
        expect(task_list[0].text).to have_content 'first_task_title'
        # expect(task_list[1].text).to have_content 'second_task_title'
        # expect(task_list[3].text).to have_content 'third_task_title'
      end
    end
  end

  describe '検索機能' do
    let!(:first_task) { FactoryBot.create(:first_task, title: 'first_task_title', user_id: @current_user.id) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'second_task_title', user_id: @current_user.id) }
    let!(:third_task) { FactoryBot.create(:third_task, title: 'third_task_title', user_id: @current_user.id) }
    before do
      visit tasks_path
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索ワードを含むタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        fill_in 'search_title', with: 'first'
        click_button '検索'
        expect(page).to have_content 'first_task_title'
        expect(page).not_to have_content 'second_task_title'
        expect(page).not_to have_content 'third_task_title'
      end
    end
    context 'ステータスで検索した場合' do
      it "検索したステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        select '未着手', from: 'search_status'
        click_button '検索'
        expect(page).to have_content 'first_task_title'
        expect(page).not_to have_content 'second_task_title'
        expect(page).not_to have_content 'third_task_title'
      end
    end
    context 'タイトルとステータスで検索した場合' do
      it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        fill_in 'search_title', with: 'first'
        select '未着手', from: 'search_status'
        click_button '検索'
        expect(page).to have_content 'first_task_title'
        expect(page).not_to have_content 'second_task_title'
        expect(page).not_to have_content 'third_task_title'
      end
    end
  end
  describe '検索機能' do
    let!(:first_label) { FactoryBot.create(:first_label, user_id: @current_user.id) }
    let!(:first_task) { FactoryBot.create(:first_task, title: 'first_task_title', user_id: @current_user.id) }
    let!(:label_task) { FactoryBot.create(:label_task, task_id: first_task.id, label_id: first_label.id )}
    before do
      visit tasks_path
    end
    
    context 'ラベルで検索をした場合' do
      it "そのラベルの付いたタスクがすべて表示される" do
        select 'test1', from: 'search_label_id'
        find('#search_task').click
        expect(page).to have_content 'first_task_title'
        expect(page).not_to have_content 'second_task_title'
        expect(page).not_to have_content 'third_task_title'
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
      end
    end
  end
end