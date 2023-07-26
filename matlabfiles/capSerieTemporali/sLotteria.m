cn = 520; 
vy = randi(90, cn, 1);
plot(vy); xlim([0, cn+1]); hold on;
line([1 cn], [45.5 45.5],'LineStyle','--','Color', 'r'); hold off;
mean(vy)
