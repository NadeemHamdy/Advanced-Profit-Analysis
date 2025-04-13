function simpson_profit_gui
  % Create the main GUI interface
  f = figure('Name', 'Numerical Analysis Project: Simpson''s Rule Profit Analyzer', ...
             'Units', 'normalized', 'Position', [0.2 0.1 0.6 0.8], ...
             'Color', [0.96 0.96 0.98], 'NumberTitle', 'off', 'MenuBar', 'none');

  % Create main title panel
  uipanel('Title', '', 'Units', 'normalized', 'Position', [0.05 0.85 0.9 0.12], ...
         'BackgroundColor', [0.92 0.92 0.98], 'BorderType', 'line');

  % Title text
  uicontrol(f, 'Style', 'text', 'Units', 'normalized', 'Position', [0.05 0.91 0.9 0.05], ...
            'String', 'Advanced Profit Analysis Using Simpson''s Rule Integration', ...
            'FontSize', 16, 'FontWeight', 'bold', 'BackgroundColor', [0.92 0.92 0.98]);

  % Subtitle text
  uicontrol(f, 'Style', 'text', 'Units', 'normalized', 'Position', [0.05 0.88 0.9 0.03], ...
            'String', 'Numerical Analysis Project - Simpson''s Rule Implementation', ...
            'FontSize', 10, 'BackgroundColor', [0.92 0.92 0.98]);

  % Input panel
  input_panel = uipanel('Title', 'Data Input', 'FontSize', 12, ...
                        'Units', 'normalized', 'Position', [0.05 0.50 0.9 0.35], ...
                        'BackgroundColor', [0.95 0.95 0.97]);

  % Input instructions
  uicontrol(input_panel, 'Style', 'text', 'Units', 'normalized', 'Position', [0.03 0.75 0.94 0.1], ...
            'String', 'Enter days (x) and corresponding profit P(x) as comma-separated values.', ...
            'FontSize', 10, 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.95 0.95 0.97]);

  uicontrol(input_panel, 'Style', 'text', 'Units', 'normalized', 'Position', [0.03 0.65 0.94 0.1], ...
            'String', 'Note: Simpson''s rule requires an odd number of data points (even number of intervals).', ...
            'FontSize', 9, 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.95 0.95 0.97]);

  % X values (days) input
  uicontrol(input_panel, 'Style', 'text', 'Units', 'normalized', 'Position', [0.03 0.55 0.1 0.1], ...
            'String', 'x = ', 'FontSize', 11, 'HorizontalAlignment', 'right', ...
            'BackgroundColor', [0.95 0.95 0.97]);
  x_input = uicontrol(input_panel, 'Style', 'edit', 'Units', 'normalized', 'Position', [0.15 0.55 0.8 0.1], ...
                      'String', '0, 2, 4, 6, 8, 10', 'FontSize', 10);

  % P(x) values (profit) input
  uicontrol(input_panel, 'Style', 'text', 'Units', 'normalized', 'Position', [0.03 0.4 0.1 0.1], ...
            'String', 'P(x) = ', 'FontSize', 11, 'HorizontalAlignment', 'right', ...
            'BackgroundColor', [0.95 0.95 0.97]);
  p_input = uicontrol(input_panel, 'Style', 'edit', 'Units', 'normalized', 'Position', [0.15 0.4 0.8 0.1], ...
                      'String', '100, 230, 389, 467, 498, 520', 'FontSize', 10);

  % Function type selection
  uicontrol(input_panel, 'Style', 'text', 'Units', 'normalized', 'Position', [0.03 0.25 0.2 0.1], ...
            'String', 'Interpolation: ', 'FontSize', 11, 'HorizontalAlignment', 'right', ...
            'BackgroundColor', [0.95 0.95 0.97]);
  interp_type = uicontrol(input_panel, 'Style', 'popupmenu', 'Units', 'normalized', 'Position', [0.25 0.25 0.3 0.1], ...
                         'String', {'Linear', 'Cubic Spline', 'None'}, 'Value', 2, ...
                         'FontSize', 10);

  % Options panel
  options_panel = uipanel('Title', 'Advanced Options', 'FontSize', 12, ...
                         'Units', 'normalized', 'Position', [0.05 0.40 0.9 0.08], ...
                         'BackgroundColor', [0.95 0.95 0.97]);

  % Checkbox for showing area
  show_area = uicontrol(options_panel, 'Style', 'checkbox', ...
                        'Units', 'normalized', 'Position', [0.03 0.1 0.2 0.8], ...
                        'String', 'Show area under curve', ...
                        'Value', 1, 'FontSize', 10, ...
                        'BackgroundColor', [0.95 0.95 0.97]);

  % Checkbox for showing grid
  show_grid = uicontrol(options_panel, 'Style', 'checkbox', ...
                       'Units', 'normalized', 'Position', [0.28 0.1 0.2 0.8], ...
                       'String', 'Show grid', ...
                       'Value', 1, 'FontSize', 10, ...
                       'BackgroundColor', [0.95 0.95 0.97]);

  % Time period label
  uicontrol(options_panel, 'Style', 'text', 'Units', 'normalized', 'Position', [0.48 0.1 0.2 0.8], ...
            'String', 'Time unit:', 'FontSize', 10, ...
            'BackgroundColor', [0.95 0.95 0.97], ...
            'HorizontalAlignment', 'right');

  % Dropdown for time period
  time_unit = uicontrol(options_panel, 'Style', 'popupmenu', ...
                       'Units', 'normalized', 'Position', [0.7 0.1 0.2 0.8], ...
                       'String', {'Days', 'Weeks', 'Months'}, ...
                       'Value', 1, 'FontSize', 10);

  % Results panel
  result_panel = uipanel('Title', 'Calculation Results', 'FontSize', 12, ...
                         'Units', 'normalized', 'Position', [0.05 0.30 0.9 0.12], ...
                         'BackgroundColor', [0.95 0.98 0.95]);

  % Results text
  result_text = uicontrol(result_panel, 'Style', 'text', ...
                      'Units', 'normalized', 'Position', [0.03 0.1 0.94 0.8], ...  % Changed position to use more vertical space
                      'String', 'Enter data and click "Calculate" to see results', ...
                      'FontSize', 12, 'FontWeight', 'bold', ...
                      'BackgroundColor', [0.95 0.98 0.95], ...
                      'HorizontalAlignment', 'left', ... % Left alignment for better readability
                      'Max', 2);

  % Calculate button
  uicontrol(f, 'Style', 'pushbutton', 'String', 'Calculate Total Profit', ...
            'Units', 'normalized', 'Position', [0.375 0.23 0.25 0.05], 'FontSize', 12, 'FontWeight', 'bold', ...
            'BackgroundColor', [0.4 0.6 0.8], 'ForegroundColor', [1 1 1], ...
            'Callback', @(src, event) calculate_profit(x_input, p_input, result_text, f, ...
                                                      interp_type, show_area, show_grid, time_unit));

  % Export button
  uicontrol(f, 'Style', 'pushbutton', 'String', 'Export Results', ...
            'Units', 'normalized', 'Position', [0.65 0.23 0.2 0.05], 'FontSize', 11, ...
            'Callback', @export_results);

  % Help button
  uicontrol(f, 'Style', 'pushbutton', 'String', '?', ...
            'Units', 'normalized', 'Position', [0.86 0.23 0.04 0.05], 'FontSize', 11, ...
            'Callback', @show_help);

  % Create initial empty plot
  subplot_handle = subplot('Position', [0.1 0.03 0.8 0.2]);
  title('Profit Analysis Graph');
  xlabel('Time');
  ylabel('Profit ($)');
  grid on;

  % Set app data for later use
  setappdata(f, 'subplot_handle', subplot_handle);
end

function calculate_profit(x_input, p_input, result_text, f, interp_type, show_area, show_grid, time_unit)
  try
    % Get input data
    x_str = get(x_input, 'String');
    p_str = get(p_input, 'String');

    % Parse input values
    x = str2num(x_str);
    p = str2num(p_str);

    % Input validation
    if isempty(x) || isempty(p)
      set(result_text, 'String', 'Error: Please enter valid numeric data.');
      return;
    end

    if length(x) ~= length(p)
      set(result_text, 'String', 'Error: x and P(x) must have the same length!');
      return;
    end

    if length(x) < 3
      set(result_text, 'String', 'Error: At least 3 data points are required for Simpson''s rule.');
      return;
    end

    % Sort data points in case they're not in order
    [x, idx] = sort(x);
    p = p(idx);

    % Check if we have even number of intervals (odd number of points)
    if mod(length(x) - 1, 2) ~= 0
      % If not even, interpolate to add points
      x_original = x;
      p_original = p;

      % Create new x with even spacing
      x_new = linspace(x(1), x(end), 2*length(x)-1);

      % Interpolate to get new p values
      p_new = interp1(x, p, x_new, 'spline');

      % Update x and p
      x = x_new;
      p = p_new;

      % Notify user
      warning_msg = ['Note: Added interpolated points to ensure even intervals. ', ...
                    'Now using ', num2str(length(x)), ' points.'];
    else
      warning_msg = '';
      x_original = x;
      p_original = p;
    end

    % Calculate using Simpson's rule
    h = (x(end) - x(1)) / (length(x) - 1);
    profit_sum = p(1) + p(end);

    for i = 2:length(p)-1
      if mod(i, 2) == 0
        profit_sum = profit_sum + 4 * p(i);
      else
        profit_sum = profit_sum + 2 * p(i);
      end
    end

    total_profit = profit_sum * h / 3;

    % Get time unit text
    time_units = get(time_unit, 'String');
    selected_unit = time_units{get(time_unit, 'Value')};

    % Display results
    result_str = sprintf('Estimated Total Profit: $%.2f over %.1f %s', ...
                        total_profit, x(end) - x(1), lower(selected_unit));

    if !isempty(warning_msg)
      result_str = [result_str, ' | ', warning_msg];
    end

    set(result_text, 'String', result_str);

    % Store results in app data for export
    result_data.x = x;
    result_data.p = p;
    result_data.x_original = x_original;
    result_data.p_original = p_original;
    result_data.total_profit = total_profit;
    result_data.time_span = x(end) - x(1);
    result_data.time_unit = lower(selected_unit);
    result_data.simpson_h = h;
    setappdata(f, 'result_data', result_data);

    % Plot results
    plot_results(f, x, p, x_original, p_original, interp_type, show_area, show_grid, time_unit);

  catch err
    set(result_text, 'String', ['Error: ', err.message]);
  end
end

function plot_results(f, x, p, x_original, p_original, interp_type, show_area, show_grid, time_unit)
  % Get the subplot handle
  ax = getappdata(f, 'subplot_handle');

  % Clear previous plot
  cla(ax);

  hold(ax, 'on');

  % Get interpolation type
  interp_types = get(interp_type, 'String');
  selected_interp = interp_types{get(interp_type, 'Value')};

  % Get time unit for axis label
  time_units = get(time_unit, 'String');
  selected_unit = time_units{get(time_unit, 'Value')};

  % Create dense x values for smooth curve
  x_dense = linspace(x(1), x(end), 500);

  % Plot based on interpolation type
  if strcmp(selected_interp, 'Cubic Spline')
    % Plot original data points
    plot(ax, x_original, p_original, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5);

    % Plot interpolated points if any
    if length(x) > length(x_original)
      interp_indices = setdiff(1:length(x), 1:length(x_original)/(length(x)-1):length(x));
      plot(ax, x(interp_indices), p(interp_indices), 'ro', 'MarkerSize', 6);
    end

    % Plot smooth curve
    p_spline = spline(x, p, x_dense);
    plot(ax, x_dense, p_spline, 'b-', 'LineWidth', 2);

    % Fill area if selected
    if get(show_area, 'Value')
      fill(ax, [x_dense, x_dense(1)], [p_spline, 0], 'b', 'FaceAlpha', 0.1);
    end

  elseif strcmp(selected_interp, 'Linear')
    % Plot original data points
    plot(ax, x, p, 'bo', 'MarkerSize', 8);

    % Plot linear segments
    plot(ax, x, p, 'b-', 'LineWidth', 2);

    % Fill area if selected
    if get(show_area, 'Value')
      fill(ax, [x, x(1)], [p, 0], 'b', 'FaceAlpha', 0.1);
    end

  else % No interpolation
    % Just plot the data points
    plot(ax, x, p, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5);

    % Connect with straight lines
    plot(ax, x, p, 'b-', 'LineWidth', 1);
  end

  % Add vertical lines to show Simpson's rule segments
  for i = 1:length(x)
    line(ax, [x(i) x(i)], [0 p(i)], 'Color', [0.7 0.7 0.7], 'LineStyle', ':');
  end

  % Set grid based on checkbox
  if get(show_grid, 'Value')
    grid(ax, 'on');
  else
    grid(ax, 'off');
  end

  % Add labels and title
  xlabel(ax, ['Time (', selected_unit, ')']);
  ylabel(ax, 'Profit ($)');
  title(ax, 'Profit Analysis with Simpson''s Rule Integration');

  hold(ax, 'off');
end

function export_results(src, event)
  % Get figure handle
  f = gcbf;

  % Get stored data
  result_data = getappdata(f, 'result_data');

  if isempty(result_data)
    errordlg('No calculation results available to export. Please run a calculation first.', 'Export Error');
    return;
  end

  % Create export dialog
  export_dialog = figure('Name', 'Export Results', 'Position', [0.4 0.4 0.3 0.3], ...
                        'NumberTitle', 'off', 'MenuBar', 'none');

  % Text field for filename
  uicontrol(export_dialog, 'Style', 'text', 'Units', 'normalized', 'Position', [0.05 0.8 0.9 0.1], ...
            'String', 'Export Calculation Results', 'FontSize', 12, 'FontWeight', 'bold');

  uicontrol(export_dialog, 'Style', 'text', 'Units', 'normalized', 'Position', [0.05 0.65 0.3 0.1], ...
            'String', 'Filename:', 'FontSize', 10, 'HorizontalAlignment', 'left');

  filename_input = uicontrol(export_dialog, 'Style', 'edit', 'Units', 'normalized', ...
                            'Position', [0.4 0.65 0.5 0.1], 'String', 'simpson_profit_results', 'FontSize', 10);

  % Format selection
  uicontrol(export_dialog, 'Style', 'text', 'Units', 'normalized', 'Position', [0.05 0.5 0.3 0.1], ...
            'String', 'Format:', 'FontSize', 10, 'HorizontalAlignment', 'left');

  format_select = uicontrol(export_dialog, 'Style', 'popupmenu', 'Units', 'normalized', ...
                           'Position', [0.4 0.5 0.5 0.1], ...
                           'String', {'CSV file (.csv)', 'MATLAB file (.mat)'}, ...
                           'Value', 1, 'FontSize', 10);

  % Export button
  uicontrol(export_dialog, 'Style', 'pushbutton', 'Units', 'normalized', 'Position', [0.35 0.2 0.3 0.15], ...
            'String', 'Export', 'FontSize', 12, ...
            'Callback', @(src, event) do_export(filename_input, format_select, result_data, export_dialog));
end

function do_export(filename_input, format_select, result_data, dialog)
  % Get filename and format
  filename = get(filename_input, 'String');
  formats = get(format_select, 'String');
  selected_format = formats{get(format_select, 'Value')};

  try
    % Export based on format
    if ~isempty(strfind(selected_format, 'CSV'))
      % Prepare data for CSV
      x = result_data.x;
      p = result_data.p;

      % Write to CSV file
      csv_filename = [filename, '.csv'];
      fid = fopen(csv_filename, 'w');
      fprintf(fid, 'Time,Profit\n');
      for i = 1:length(x)
        fprintf(fid, '%f,%f\n', x(i), p(i));
      end
      fprintf(fid, 'Total Profit,%f\n', result_data.total_profit);
      fclose(fid);

    else % MATLAB file
      % Save as .mat file
      save([filename, '.mat'], '-struct', 'result_data');
    end

    % Show success message
    msgbox(['Results successfully exported to ', filename], 'Export Complete');

    % Close dialog
    close(dialog);

  catch err
    errordlg(['Export failed: ', err.message], 'Export Error');
  end
end

function show_help(src, event)
  % Create help dialog with a more reliable text display approach
  help_dialog = figure('Name', 'Help - Simpson''s Rule Profit Calculator', ...
                      'Position', [500 200 600 500], 'NumberTitle', 'off', ...
                      'MenuBar', 'none', 'Color', [0.96 0.96 0.98]);

  % Create a panel for the help content
  help_panel = uipanel('Parent', help_dialog, 'Position', [0.03 0.12 0.94 0.85], ...
                       'BackgroundColor', [0.98 0.98 1]);

  % Title
  uicontrol(help_panel, 'Style', 'text', 'Position', [20 430 540 30], ...
            'String', 'Simpson''s Rule Profit Calculator', ...
            'FontSize', 16, 'FontWeight', 'bold', 'BackgroundColor', [0.98 0.98 1]);

  % Help content using standard text controls instead of HTML
  % How to use section
  uicontrol(help_panel, 'Style', 'text', 'Position', [20 390 540 30], ...
            'String', 'How to use this tool:', ...
            'FontSize', 12, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.98 0.98 1]);

  instructions = {'1. Enter Data: Input comma-separated values for days/time (x) and corresponding profit P(x).', ...
                  '2. Select Options: Choose interpolation type and display options.', ...
                  '3. Calculate: Click "Calculate Total Profit" to run Simpson''s rule integration.', ...
                  '4. Export: Export results in various formats for reporting.'};

  uicontrol(help_panel, 'Style', 'text', 'Position', [30 310 530 80], ...
            'String', instructions, ...
            'FontSize', 11, 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.98 0.98 1]);

  % About Simpson's Rule section
  uicontrol(help_panel, 'Style', 'text', 'Position', [20 270 540 30], ...
            'String', 'About Simpson''s Rule:', ...
            'FontSize', 12, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.98 0.98 1]);

  about_text = {'Simpson''s Rule approximates the integral of a function using quadratic polynomials.', ...
                'The formula is:', ...
                '∫[a to b] f(x)dx ≈ (h/3)[f(x₀) + 4f(x₁) + 2f(x₂) + 4f(x₃) + ... + f(xₙ)]', ...
                'where h = (b-a)/n and n is an even number of intervals.'};

  uicontrol(help_panel, 'Style', 'text', 'Position', [30 180 530 90], ...
            'String', about_text, ...
            'FontSize', 11, 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.98 0.98 1]);

  % Requirements section
  uicontrol(help_panel, 'Style', 'text', 'Position', [20 140 540 30], ...
            'String', 'Requirements:', ...
            'FontSize', 12, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.98 0.98 1]);

  req_text = {'• Data must have an odd number of points (even number of intervals).', ...
              '• If even number of points is provided, interpolation will be added automatically.'};

  uicontrol(help_panel, 'Style', 'text', 'Position', [30 80 530 60], ...
            'String', req_text, ...
            'FontSize', 11, 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.98 0.98 1]);

  % Close button
  uicontrol(help_dialog, 'Style', 'pushbutton', 'Position', [250 20 100 30], ...
            'String', 'Close', 'FontSize', 11, 'BackgroundColor', [0.4 0.6 0.8], ...
            'ForegroundColor', [1 1 1], 'FontWeight', 'bold', ...
            'Callback', @(src, event) close(help_dialog));
end
