classdef cableTrussUnit < handle
    properties
        aLength
        bLength
        T
        horzBarGfxProto
        vertBarGfxProto
        pulleyGfxProto
        handleBar1
        handleBar2
        handleBar3
        handleBar4
        barWidth
    end
    methods
        function obj = cableTrussUnit(length_a, length_b)
            obj.aLength = length_a;
            obj.bLength = length_b;
            obj.T = eye(3);
            obj.T(1,3) = obj.bLength;
            obj.barWidth = 0.1;
            obj.setGraphicPrototypes();
        end
        
        function setRotation(obj, theta)
            obj.T(1:2,1:2) = [cos(theta), -sin(theta);
                                    sin(theta), cos(theta)];
            obj.T(1:2,3) = [obj.bLength*cos(theta); obj.bLength*sin(theta)];
        end
        
        function setGraphicPrototypes(obj)
            % Create the basic horizontal link shape
            gamma = -pi/2:pi/24:pi/2;
            x_right_curve = (obj.barWidth/2)*cos(gamma);
            y_right_curve = (obj.barWidth/2)*sin(gamma);
            gamma = pi/2:pi/24:3*pi/2;
            x_left_curve = (obj.barWidth/2)*cos(gamma)-obj.aLength;
            y_left_curve = (obj.barWidth/2)*sin(gamma);
            obj.horzBarGfxProto = [x_right_curve x_left_curve;
                                    y_right_curve y_left_curve];
                                
            % Create the basic vertical link shape
            gamma = -pi/2:pi/12:pi/2;
            x_right_curve = (obj.barWidth/2)*cos(gamma);
            y_right_curve = (obj.barWidth/2)*sin(gamma);
            gamma = pi/2:pi/12:3*pi/2;
            x_left_curve = (obj.barWidth/2)*cos(gamma)-obj.bLength;
            y_left_curve = (obj.barWidth/2)*sin(gamma);
            obj.vertBarGfxProto = [x_right_curve x_left_curve;
                                    y_right_curve y_left_curve];
        end
        
        function drawTrussUnit(obj,prevTransform,drawBaseBar)
            T_world = prevTransform*obj.T;
            if drawBaseBar
                obj.drawBar4(prevTransform);
            end
            obj.drawBar2(T_world);
            obj.drawBar1(T_world);
            obj.drawBar3(T_world);
        end
        
        function drawBar1(obj,T)
            % Transform drawing prototype to link axis location
            XY1 = [obj.vertBarGfxProto; ones(1,size(obj.vertBarGfxProto,2))];
            for i = 1:size(XY1,2)
                XY1(:,i) = T*XY1(:,i);
            end
            
            % Plot the transformed bar
            if isempty(obj.handleBar1)
                obj.handleBar1 = fill(XY1(1,:),XY1(2,:),1/255*[100 150 200]);
            else
                obj.handleBar1.XData = XY1(1,:);
                obj.handleBar1.YData = XY1(2,:);
            end
        end
        
        function drawBar2(obj,T)
            % Translate prototype to link axis location
            XY = obj.horzBarGfxProto + T(1:2,3);
            
            % Plot the transformed bar
            if isempty(obj.handleBar2)
                obj.handleBar2 = fill(XY(1,:),XY(2,:),1/255*[200 0 0]);
            else
                obj.handleBar2.XData = XY(1,:);
                obj.handleBar2.YData = XY(2,:);
            end
        end
        
        function drawBar3(obj,T)
            % Transform drawing prototype to link axis location
            XY1 = [obj.vertBarGfxProto; ones(1,size(obj.vertBarGfxProto,2))];
            for i = 1:size(XY1,2)
                XY1(:,i) = T*XY1(:,i);
            end
            
            % Translate to be on opposite end of Bar 2
            XY1 = XY1 - [obj.aLength; 0; 0];
            
            % Plot the transformed bar
            if isempty(obj.handleBar3)
                obj.handleBar3 = fill(XY1(1,:),XY1(2,:),1/255*[100 150 200]);
            else
                obj.handleBar3.XData = XY1(1,:);
                obj.handleBar3.YData = XY1(2,:);
            end
        end
        
        function drawBar4(obj,T)
            % Translate prototype to T's translation values
            XY = obj.horzBarGfxProto + T(1:2,3);
            
            % Plot the translated bar
            if isempty(obj.handleBar4)
                obj.handleBar4 = fill(XY(1,:),XY(2,:),1/255*[200 0 0]);
            else
                obj.handleBar4.XData = XY(1,:);
                obj.handleBar4.YData = XY(2,:);
            end
        end
        
        function resetGfx(obj)
            obj.handleBar1 = [];
            obj.handleBar2 = [];
            obj.handleBar3 = [];
            obj.handleBar4 = [];
        end
    end
end