function applyDataColors () {
        var runs_projections = document.querySelectorAll('.data-runs');
        setColors(runs_projections, [3, 3.3, 3.7, 4, 4.3, 4.5, 4.7], false);
        var rain_projections = document.querySelectorAll('.data-rain');
        for(var i = 0; i < rain_projections.length; i++){
            var rain = rain_projections[i];
            var rain_percentage = rain.textContent.replace('%', '');
            if(!/No Rain/.test(rain_percentage)){
                rain_percentage = parseInt(rain_percentage);
                if(rain_percentage < 30){
                    rain.setAttribute('class', 'td-color-7');
                } else if (rain_percentage < 75){
                    rain.setAttribute('class', 'td-color-3');
                } else {
                    rain.setAttribute('class', 'td-color-1');
                }
            } else {
                rain.setAttribute('class', 'td-color-7');
            }
        }

        var wind_projections = document.querySelectorAll('.data-wind');
        for(i = 0; i < wind_projections.length; i++){
            var wind = wind_projections[i];
            var wind_value = wind.textContent;
            if(/\d+\sMPH/.test(wind_value)){
                var wind_mph = parseInt(wind_value.match(/(\d+)\sMPH/)[1]);
                if(wind_mph > 20){
                    if(/\sIn\s/.test(wind_value)){
                        wind.setAttribute('class', 'td-color-1')
                    } else {
                        wind.setAttribute('class', 'td-color-7')
                    }
                } else if (wind_mph > 9){
                    if(/\sin\s/.test(wind_value)){
                        wind.setAttribute('class', 'td-color-2')
                    } else {
                        wind.setAttribute('class', 'td-color-6')
                    }
                }
            }
        }
        var temp_projections = document.querySelectorAll('.data-temp');
        for(i = 0; i < temp_projections.length; i++){
            var temp = temp_projections[i];
            var temp_value = parseInt(temp.textContent.replace('°', ''))
            if(temp_value < 45){
                temp.setAttribute('class', 'td-color-cold');
            } else if (temp_value < 60 ){
                temp.setAttribute('class', 'td-color-chill');
            } else if(temp_value < 90){
                temp.setAttribute('class', 'td-color-2');
            } else {
                temp.setAttribute('class', 'td-color-1');
            }
        }
        var team_batting_index_0 = document.querySelectorAll('.team-batting-data-0');
        setColors(team_batting_index_0, [.29, .3, .31, .32, .34, .37, .39], false);
        var team_batting_index_1 = document.querySelectorAll('.team-batting-data-1');
        setColors(team_batting_index_1, [.29, .3, .31, .32, .34, .37, .4], false);
        var team_batting_index_2 = document.querySelectorAll('.team-batting-data-2');
        setColors(team_batting_index_2, [.08, .1, .12, .14, .17, .2, .25], false);
        var team_batting_index_3 = document.querySelectorAll('.team-batting-data-3');
        setColors(team_batting_index_3, [2, 23, 28, 3, 35, 38, 4], false);
        var team_batting_index_4 = document.querySelectorAll('.team-batting-data-4');
        setColors(team_batting_index_4, [35], false);
        var team_batting_index_5 = document.querySelectorAll('.team-batting-data-5');
        setColors(team_batting_index_5, [27.5, 25, 22, 20, 16, 12.5, 10], true);
        
        var pitcher_index_0 = document.querySelectorAll('.pitcher-data-0');
        setColors(pitcher_index_0, [.39, .37, .34, .32, .31, .3, .29], true);
        var pitcher_index_1 = document.querySelectorAll('.pitcher-data-1');
        setColors(pitcher_index_1, [.4, .37, .34, .32, .31, 3, .29], true);
        var pitcher_index_2 = document.querySelectorAll('.pitcher-data-2');
        setColors(pitcher_index_2, [10, 12.5, 16, 20, 22, 25, 27.5], false);
        var pitcher_index_3 = document.querySelectorAll('.pitcher-data-3');
        setColors(pitcher_index_3, [40, 38, 35, 30, 28, 23, 20], true);
        var pitcher_index_4 = document.querySelectorAll('.pitcher-data-4');
        setColors(pitcher_index_4, [35], '');
        var pitcher_index_5 = document.querySelectorAll('.pitcher-data-5');
        setColors(pitcher_index_5, [1], '');
        var pitcher_index_6 = document.querySelectorAll('.pitcher-data-6');
        setColors(pitcher_index_6, [4.7, 4.4, 4.1, 3.8, 3.5, 3.2, 2.9], true);

        var batters_index_7 = document.querySelectorAll('.batter-data-7');
        setColors(batters_index_7, [.29, .3, .31, .32, .34, .37, .39], false);
        var batters_index_8 = document.querySelectorAll('.batter-data-8');
        setColors(batters_index_8, [.29, .3, .31, .32, .34, .37, .4], false);
        var batters_index_9 = document.querySelectorAll('.batter-data-9');
        setColors(batters_index_9, [.08, .1, .12, .14, .17, .2, .25], false);
        var batters_index_10 = document.querySelectorAll('.batter-data-10');
        setColors(batters_index_10, [2, 23, 28, 3, 35, 38, 4], false);
        var batters_index_11 = document.querySelectorAll('.batter-data-11');
        setColors(batters_index_11, [35], false);
        var batters_index_12 = document.querySelectorAll('.batter-data-12');
        setColors(batters_index_12,  [27.5, 25, 22, 20, 16, 12.5, 10], true);
        var batters_index_13 = document.querySelectorAll('.batter-data-13');
        setColors(batters_index_13,  [10], true);
        var batters_index_14 = document.querySelectorAll('.batter-data-14');
        setColors(batters_index_14,  [10], true);
        var batters_index_15 = document.querySelectorAll('.batter-data-15');
        setColors(batters_index_15,  [.29, .3, .31, .32, .34, .37, .4], false);

        var dollar_amounts = document.querySelectorAll('.dollar-data');
        for(i = 0; i < dollar_amounts.length; i++){
            var dollar = dollar_amounts[i];
            dollar.textContent = '$' + dollar.textContent;
        }
        var lineup_confirmed = document.querySelectorAll('.data-confirmed');
        for(i = 0; i < lineup_confirmed.length; i++){
            var lineup = lineup_confirmed[i];
            if(/NOT CONFIRMED/i.test(lineup.textContent)){
                lineup.setAttribute('class', 'data-unconfirmed data-table-dark');
            }
        }
};
function setColors(nodes, limits, is_greater) {
    for(var i = 0; i < nodes.length; i++){
        var td = nodes[i];
        var td_value =  parseFloat(td.textContent.replace('%', ''));
        if(isNaN(td_value)){
            var class_name = 'td-color-na';
        } else {
            class_name = evalLimits(td_value, limits, is_greater);
        }
        td.setAttribute('class', class_name);
    }
}
function evalLimits(value, limits, is_greater){
    if(limits.length === 1){
        if (is_greater === ''){
            if (value < limits[0]) {
                return 'td-color-7';
            } else if (value === limits[0]) {
                return 'td-color-4';
            }
            return 'td-color-1';
        } else if (is_greater) {
            if (value > limits[0]) {
                return 'td-color-7';
            }
            return 'td-color-4';
        } else {
            if (value < limits[0]) {
                return 'td-color-1';
            } else if (value === limits[0]) {
                return 'td-color-4';
            }
            return 'td-color-7';

        }
    } else{
        for(var i = 0; i < limits.length; i++) {
            if (is_greater){
                if (value > limits[i]) {
                    return 'td-color-' + String(i);
                }
            } else {
                if (value < limits[i]) {
                    return 'td-color-' + String(i);
                }
            }
        }
        return 'td-color-7';
    }
}