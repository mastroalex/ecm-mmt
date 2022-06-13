function fcm = fcm (epstilde_cell, epstilde_med)
fcm = (epstilde_cell-epstilde_med)./(epstilde_cell+2*epstilde_med);
end