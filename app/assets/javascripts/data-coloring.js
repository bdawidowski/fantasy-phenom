document.onreadystatechange = function () {
    if (document.readyState === 'complete') {
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
        setColors(pitcher_index_4, [35], false);
        // var pitcher_index_5 = document.getElementsByClassName('pitcher-data-5');
        // setColors(pitcher_index_5, [], false);
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
        // var batters_index_13 = document.querySelectorAll('.batter-data-13');
        // setColors(batters_index_13,  [27.5, 25, 22, 20, 16, 12.5, 10], true);





        var dollar_amounts = document.getElementsByClassName('dollar-data');
        for(var i = 0; i < dollar_amounts.length; i++){
            var dollar = dollar_amounts[i];
            dollar.textContent = '$' + dollar.textContent;
        }



    }
};
function setColors(nodes, limits) {
    console.log(nodes)
    for(var i = 0; i < nodes.length; i++){
        var td = nodes[i];
        var td_value =  parseFloat(td.textContent.replace('%', ''));
        if(isNaN(td_value)){
            var class_name = 'td-color-4';
        } else {
            class_name = evalLimits(td_value, limits);
        }
        td.setAttribute('class', class_name);
        console.log(td);
    }
}
function evalLimits(value, limits, is_greater){
    if(limits.length === 1){
        if(value < limits[0]){
            return 'td-color-1';
        } else if (value === limits[0]){
            return 'td-color-4';
        } else {
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