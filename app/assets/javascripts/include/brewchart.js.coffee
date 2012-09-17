scaleDate = (scale, datestring) ->
  scale(+(new Date(datestring)))

# just assume first step of brew is current for now. Refactor later.
currentStep = (datum) ->
  datum.brew.steps[0].step

draw = (data) ->
  margin = {top: 20, right: 15, bottom: 25, left: 200}
  cornerRadius = 8
  totalWidth = 960
  width = totalWidth - margin.left - margin.right
  height = (data.length * 24)
  totalHeight = height + margin.top + margin.bottom
  capsuleHeightPercent = 0.7
  now = +(new Date())
  
  brewchart = d3.select('#brewchart')
    .append('svg:svg')
      .attr('width', totalWidth)
      .attr('height', totalHeight)
      .attr('class', 'brewchart')
      
  # calculate scales (mapping values -> pixels)
  mindate = d3.min(data, (b) ->
    return d3.min(b.brew.steps, (s)->
      return +(new Date(s.step.start))
    )
  )
  maxdate = d3.max(data, (b) ->
    return d3.max(b.brew.steps, (s) ->
      return +(new Date(s.step.latest_end))
    )
  )
  maxdate = d3.max([maxdate, now])
  
  x = d3.time.scale()
    .domain([mindate, maxdate])
    .range([0, width])
    
  y = d3.scale.linear().domain([0, data.length]).range([0, height])
  
  # main drawing area within chart
  main = brewchart.append('g')
    .attr('transform', "translate(#{margin.left},#{margin.top})")
    .attr('width', width)
    .attr('height', height)
    .attr('class', 'mainArea')
    
  # draw horizontal lines separating brews
  main.append('g').selectAll('.laneLines')
    .data(data)
    .enter().append('line')
    .attr('x1', 0)
    .attr('y1', (d, i) -> d3.round(y(i)) )
    .attr('x2', width)
    .attr('y2', (d, i) -> d3.round(y(i)) )
    .attr('stroke', 'lightgray')
    .attr('class', 'laneLine')

  # labels
  main.append('g').selectAll('.laneText')
    .data(data)
    .enter().append('text')
    .text( (d) -> d.brew.name )
    .attr('x', -10)
    .attr('y', (d, i) -> y(i + .5) )
    .attr('dy', '0.5em')
    .attr('text-anchor', 'end')
    .attr('class', 'laneText')
      
  # draw x axes
  xDateAxis = d3.svg.axis()
    .scale(x)
    .orient('bottom')
    .ticks(d3.time.days, 1)
    .tickFormat(d3.time.format('%d'))
    .tickSize(6, 0, 0)
  xMonthAxis = d3.svg.axis()
    .scale(x)
    .orient('top')
    .ticks(d3.time.months, 1)
    .tickFormat(d3.time.format('%b %Y'))
    .tickSize(15, 0, 0)
    
  main.append('g')
    .attr('transform', "translate(0, #{height})")
    .attr('class', 'main axis date')
    .call(xDateAxis)
    
  main.append('g')
    .attr('transform', 'translate(0, 0.5)')
    .attr('class', 'main axis month')
    .call(xMonthAxis)
    .selectAll('text')
      .attr('dx', 5)
      .attr('dy', 12)
      
  # draw our steps!
  stepRects = main.append('g')
    .attr('class', 'stepRects')
  
  # longer rects that define maximum length drawn first (underneath)
  latestRects = stepRects.selectAll('latestRect')
    .data(data, (d)-> d.brew.id)
    .enter()
    .append('rect')
      .attr('x',  (d)-> scaleDate(x, currentStep(d).start) )
      .attr('width', (d)-> scaleDate(x, currentStep(d).latest_end) - scaleDate(x, currentStep(d).start))
      .attr('y', (d,i)-> y(i) + .1*y(1) + 0.5)
      .attr('height', (d,i)-> capsuleHeightPercent*y(1))
      .attr('class', 'latestRect stepRect')
      .attr('rx', cornerRadius)
      .attr('ry', cornerRadius)
  
  # shorter rects that define minimum time drawn on top
  soonerRects = stepRects.selectAll('soonerRect')
    .data(data, (d)-> d.brew.id)
    .enter()
    .append('rect')
      .attr('x',  (d)-> scaleDate(x, currentStep(d).start) )
      .attr('width', (d)-> scaleDate(x, currentStep(d).soonest_end) - scaleDate(x, currentStep(d).start))
      .attr('y', (d,i)-> y(i) + .1*y(1) + 0.5)
      .attr('height', (d,i)-> capsuleHeightPercent*y(1))
      .attr('class', 'soonerRect stepRect')
      .attr('rx', cornerRadius)
      .attr('ry', cornerRadius)
  
  # add labels
  labels = stepRects.selectAll('text')
    .data(data, (d)-> d.brew.id)
    .enter()
    .append('text')
      .text((d)-> currentStep(d).name)
      .attr('x', (d) -> (scaleDate(x, currentStep(d).soonest_end) - scaleDate(x, currentStep(d).start)) / 2 + scaleDate(x, currentStep(d).start))
      .attr('y', (d, i)-> y(i + 0.6))
      .attr('text-anchor', 'middle')
      .attr('class', 'stepLabel')
  
  # draw line at "today"
  main.append('line')
    .attr('x1', x(now) + 0.5)
    .attr('x2', x(now) + 0.5)
    .attr('y1', 0)
    .attr('y2', height)
    .attr('class', 'todayLine')
  
  
  
  #console.log("completed draw")
    

d3.json('/brews.json', draw);
