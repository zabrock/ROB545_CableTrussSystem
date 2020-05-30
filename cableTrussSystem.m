classdef cableTrussSystem < handle
    properties
        trussUnits
        numUnits
        figHandle
    end
    methods
        function obj = cableTrussSystem(numUnits, length_a, length_b)
            for i = 1:numUnits
                obj.trussUnits = [obj.trussUnits, cableTrussUnit(length_a, length_b)];
            end
            obj.figHandle = figure();
        end
        
        function drawTrussSystem(obj,theta,axis_limits)
            % Reset graphics if figure was deleted
            if ~isvalid(obj.figHandle)
                obj.figHandle = figure(); hold on;
                obj.resetTrussUnitGfx();
            else
                figure(obj.figHandle); hold on;
            end
            if length(theta) ~= length(obj.trussUnits)
                error('Length of theta does not match number of truss units');
            end
            prevTransform = eye(3);
            drawBaseUnit = 1;
            for i = 1:length(theta)
                obj.trussUnits(i).setRotation(theta(i));
                obj.trussUnits(i).drawTrussUnit(prevTransform,drawBaseUnit);
                drawBaseUnit = 0;
                prevTransform = prevTransform*obj.trussUnits(i).T;
            end
            if exist('axis_limits','var') && ~isempty(axis_limits)
                axis(axis_limits);
            end
            axis('equal');
            hold off;
        end
        
        function resetTrussUnitGfx(obj)
            for i = 1:length(obj.trussUnits)
                obj.trussUnits(i).resetGfx();
            end
        end
    end
end