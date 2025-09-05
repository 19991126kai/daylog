module SharesHelper
  def minutes_to_hm(mins)
    m = mins.to_i
    m = 0 if m.negative?
    h, r = m.divmod(60)
    return "#{r}分"   if h.zero?
    return "#{h}時間" if r.zero?
    "#{h}時間#{r}分"
  end
end
