$(document).ready ->
  $ ->
    $('#from').datepicker({ dateFormat: 'dd-mm-yy' })
    return
  $ ->
    $('#to').datepicker({ dateFormat: 'dd-mm-yy' })
    return

  tableBody = _.template('<%_.forEach(goods, function (revenueData) {%>' + '<tr><td><%=revenueData.title%></td><td><%=revenueData.revenue%></td></tr>' + '<%})%>')

  $('#refresh-btn').click (e) ->
    e.preventDefault()
    $.getJSON '/sales', $('#search-form').serialize(), (data) ->
      $("#main-table tbody").html('')
      if data?.goods?.length > 0
        data.goods.push({title: "Total", revenue: data.total_revenue})
        $("#main-table tbody").html(tableBody(data))
      return
    return
