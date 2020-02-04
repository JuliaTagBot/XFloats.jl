XFloat32(x::XFloat16) = reinterpret(XFloat32, Float64(reinterpret(Float32,x)))
XFloat16(x::XFloat32) = reinterpret(XFloat16, Float32(reinterpret(Float64,x)))

XFloat32(x::Float64) = reinterpret(XFloat32, x)
XFloat32(x::Float32) = reinterpret(XFloat32, Float64(x))
XFloat32(x::Float16) = reinterpret(XFloat32, Float64(x))
XFloat32(x::Integer) = reinterpret(XFloat32, Float64(Float32(x)))
XFloat32(x::Real) = XFloat32(Float64(x))

XFloat16(x::Float64) = reinterpret(XFloat16, Float32(x))
XFloat16(x::Float32) = reinterpret(XFloat16, x)
XFloat16(x::Float16) = reinterpret(XFloat16, Float32(x))
XFloat16(x::Integer) = reinterpret(XFloat16, Float32(Float16(x)))
XFloat16(x::Real) = XFloat16(Float32(x))

Float64(x::XFloat32) = reinterpret(Float64, x)
Float32(x::XFloat32) = Float32(Float64(x))
Float16(x::XFloat32) = Float16(Float64(x))

Float64(x::XFloat16) = Float64(Float32(x))
Float32(x::XFloat16) = reinterpret(Float32, x)
Float16(x::XFloat16) = Float16(Float32(x))

for I in (:Int8, :Int16, :Int32, :Int64, :Int128, :BigInt,
          :UInt8, :UInt16, :UInt32, :UInt64, :UInt128,)
    @eval begin
        $I(x::XFloat32) = $I(Float64(x))
        $I(x::XFloat16) = $I(Float32(x))
        $I(x::XFloat16) = $I(reinterpret(Float32,x))
        $I(x::XFloat32) = $I(reinterpret(Float64,x))
    end
end

XFloat16(x::BigFloat) = reinterpret(XFloat16, Float32(x))
XFloat32(x::BigFloat) = reinterpret(XFloat32, Float64(x))
BigFloat(x::XFloat16) = BigFloat(reinterpret(Float32, x))
BigFloat(x::XFloat32) = BigFloat(reinterpret(Float64, x))

XFloat16(x::Bool) = reinterpret(XFloat16, Float32(x))
XFloat32(x::Bool) = reinterpret(XFloat32, Float64(x))
Bool(x::XFloat16) = Bool(reinterpret(Float32, x))
Bool(x::XFloat32) = Bool(reinterpret(Float64, x))

XFloat16(x::Irrational{S}) where {S} = XFloat16(Float32(x))
XFloat32(x::Irrational{S}) where {S} = XFloat32(Float64(x))

function Base.frexp(x::XFloat16)
  fr,xp = frexp(Float32(x))
  return XFloat16(fr), xp
end

function Base.frexp(x::XFloat32)
  fr,xp = frexp(Float64(x))
  return XFloat32(fr), xp
end

function Base.ldexp(x::XFloat16, xp::I) where {I<:Integer}
   fr = Float32(x)
   ldxp = ldexp(fr, xp)
   return XFloat16(ldxp)
end

function Base.ldexp(x::XFloat32, xp::I) where {I<:Integer}
   fr = Float64(x)
   ldxp = ldexp(fr, xp)
   return XFloat32(ldxp)
end
