module LogsHelper
  def minutes_to_hhmm(min)
    h = min / 60
    m = min % 60
    format("%d:%02d", h, m)
  end

  def minutes_to_ja(min)
    min = min.to_i
    h = min / 60
    m = min % 60
    parts = []
    parts << "#{h}時間" if h.positive?
    parts << "#{m}分" if m.positive? || !h.positive?
    parts.join
  end
end
