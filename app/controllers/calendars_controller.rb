class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

      days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => today_plans, :wday =>wdays[(@todays_date+x).wday]}
                                                                                                          #wdaysは配列なので添字を使用して中身を取り出す。
                                                                                                          #添字を今日の日付を利用して入れたい。Date.today ←今日の日付
                                                                                                          #wdayメソッドを使用すると日付に対応した曜日が出力されます。
                                                                                                          #今日が木曜日であれば４の数字が返されます。4の数字を配列の添字として使用すればok

     
      @week_days.push(days)
    end

  end
end



#(14+0).day (14+1).day (14+2).day........(14+6).day
